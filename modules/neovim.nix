{ config, pkgs, ... }:
{
  programs.neovim = {
    # inspiration: https://github.com/MattCairns/nixos-config/blob/16021e59119800f3d8e6d1bd022f117608ef199d/modules/dev/neovim/default.nix
    enable = true;
    plugins = with pkgs.vimPlugins; [
      dashboard-nvim
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      telescope-fzf-native-nvim
      telescope-nvim
      undotree
      go-nvim
      coc-go
      coc-fzf
      coc-yaml
      coc-json
    ];
    extraConfig = ''
      lua << EOF
      ${builtins.readFile neovim-config/options.lua}
    '';
    extraPackages = [
      pkgs.shfmt
    ];
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
