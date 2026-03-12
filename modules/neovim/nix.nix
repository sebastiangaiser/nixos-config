{ ... }:
{
  programs.nixvim.plugins.lsp.servers.nixd = {
    enable = true;
    settings = {
      nixd = {
        # Point nixd at the actual nixpkgs input so package completions
        # reflect what is available in this flake.
        nixpkgs.expr = ''import (builtins.getFlake "/home/sebastian/nixos-config").inputs.nixpkgs {}'';

        formatting.command = [ "nixfmt" "--quiet" ];

        # NixOS module option completions — evaluates the full option tree
        # for the framework13 host so you get completions and docs for all
        # NixOS options while editing configuration.nix.
        options.nixos.expr = ''
          (builtins.getFlake "/home/sebastian/nixos-config").nixosConfigurations.framework13.options
        '';

        # Home Manager option completions — navigates into the HM options
        # exposed through the NixOS module so you get completions while
        # editing home.nix and the modules/ files.
        options.home-manager.expr = ''
          (builtins.getFlake "/home/sebastian/nixos-config").nixosConfigurations.framework13.options.home-manager.users.value.options
        '';
      };
    };
  };
}
