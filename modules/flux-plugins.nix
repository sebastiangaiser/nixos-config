# Flux CLI plugins — https://github.com/fluxcd/plugins
#
# Flux discovers `flux-<name>` binaries in the directory named by the
# FLUXCD_PLUGINS env var (default ~/.fluxcd/plugins) and exposes each as a
# `flux <name>` sub-command. Rather than the imperative `flux plugin install`
# (which downloads OCI artifacts into $HOME at runtime), we fetch the release
# binaries with Nix and point FLUXCD_PLUGINS at a read-only store directory.
#
# Versions and hashes are pinned in ./flux-plugins.json — Nix evaluation stays
# pure (no network), so `nixos-rebuild` remains reproducible. To pull the
# latest upstream releases, run `update-flux-plugins` (installed below); it
# queries the GitHub API, prefetches the amd64+arm64 hashes and rewrites the
# JSON. Then rebuild.
#
# Notes on the Nix-managed approach:
#   * `flux plugin list` shows the plugins as "manual" (no install receipt).
#   * `flux plugin update` leaves them untouched — Nix owns the store dir.
{
  pkgs,
  lib,
  ...
}:
let
  pins = builtins.fromJSON (builtins.readFile ./flux-plugins.json);

  # nix system -> goreleaser asset suffix used in the release filenames.
  assetSuffix =
    {
      "x86_64-linux" = "linux_amd64";
      "aarch64-linux" = "linux_arm64";
    }
    .${pkgs.stdenv.hostPlatform.system}
      or (throw "flux-plugins: unsupported system ${pkgs.stdenv.hostPlatform.system}");

  fetchFluxPlugin =
    name: pin:
    pkgs.runCommandLocal "${name}-${pin.version}" {
      src = pkgs.fetchurl {
        url = "https://github.com/${pin.repo}/releases/download/v${pin.version}/${name}_${pin.version}_${assetSuffix}.tar.gz";
        hash = pin.hashes.${assetSuffix};
      };
    } ''
      mkdir -p "$out"
      tar -C "$out" -xzf "$src" ${name}
    '';

  # Merge the individual plugin binaries into one directory for FLUXCD_PLUGINS.
  flux-plugins-dir = pkgs.symlinkJoin {
    name = "flux-plugins";
    paths = lib.mapAttrsToList fetchFluxPlugin pins;
  };

  # Refreshes ./flux-plugins.json to the latest GitHub releases. Run from
  # anywhere inside the repo, then rebuild. Honours $GITHUB_TOKEN to dodge the
  # unauthenticated API rate limit.
  update-flux-plugins = pkgs.writeShellApplication {
    name = "update-flux-plugins";
    runtimeInputs = with pkgs; [
      curl
      jq
      git
      nix
    ];
    text = ''
      out="$(git rev-parse --show-toplevel)/modules/flux-plugins.json"

      auth=()
      [ -n "''${GITHUB_TOKEN:-}" ] && auth=(-H "Authorization: Bearer $GITHUB_TOKEN")

      result='{}'
      for name in $(jq -r 'keys[]' "$out"); do
        repo=$(jq -r --arg n "$name" '.[$n].repo' "$out")
        echo "==> $name ($repo)" >&2
        tag=$(curl -fsSL "''${auth[@]}" \
          "https://api.github.com/repos/$repo/releases/latest" | jq -r .tag_name)
        version="''${tag#v}"
        echo "    latest: $version" >&2

        entry=$(jq -n --arg repo "$repo" --arg version "$version" \
          '{repo: $repo, version: $version, hashes: {}}')
        for suffix in linux_amd64 linux_arm64; do
          url="https://github.com/$repo/releases/download/$tag/''${name}_''${version}_''${suffix}.tar.gz"
          hash=$(nix store prefetch-file --json "$url" | jq -r .hash)
          echo "    $suffix: $hash" >&2
          entry=$(jq --arg s "$suffix" --arg h "$hash" '.hashes[$s] = $h' <<<"$entry")
        done
        result=$(jq --arg n "$name" --argjson e "$entry" '.[$n] = $e' <<<"$result")
      done

      jq --indent 2 -S . <<<"$result" > "$out"
      echo "==> wrote $out" >&2
    '';
  };
in
{
  home.sessionVariables.FLUXCD_PLUGINS = "${flux-plugins-dir}";
  home.packages = [ update-flux-plugins ];
}
