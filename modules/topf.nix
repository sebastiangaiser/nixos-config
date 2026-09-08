# topf — renders and applies Talos machine configs, used by the talos-ops repo.
# https://github.com/postfinance/topf
#
# Not packaged in nixpkgs, so the goreleaser release tarball is pinned here, the
# same way ./flux-plugins.nix pins its plugin binaries. The binary is statically
# linked, so unpacking it is all that is needed.
#
# To bump: raise version, then per architecture
#   nix store prefetch-file --json \
#     https://github.com/postfinance/topf/releases/download/v<version>/topf_<suffix>.tar.gz
# and paste the reported hashes below.
{
  pkgs,
  ...
}:
let
  version = "0.6.0";

  hashes = {
    linux_amd64 = "sha256-RY30sl9BgaMe02HAWSGU9+uebnsT5wlvh0VFOv3qrfs=";
    linux_arm64 = "sha256-fl1L8h8HupG4PEZT62XdPPXuZ6qPpBMcpAOzh5FHY2c=";
  };

  # nix system -> goreleaser asset suffix used in the release filenames.
  assetSuffix =
    {
      "x86_64-linux" = "linux_amd64";
      "aarch64-linux" = "linux_arm64";
    }
    .${pkgs.stdenv.hostPlatform.system}
      or (throw "topf: unsupported system ${pkgs.stdenv.hostPlatform.system}");

  topf = pkgs.runCommandLocal "topf-${version}" {
    src = pkgs.fetchurl {
      url = "https://github.com/postfinance/topf/releases/download/v${version}/topf_${assetSuffix}.tar.gz";
      hash = hashes.${assetSuffix};
    };
    meta.mainProgram = "topf";
  } ''
    mkdir -p "$out/bin"
    tar -C "$out/bin" -xzf "$src" topf
  '';
in
{
  home.packages = [ topf ];
}
