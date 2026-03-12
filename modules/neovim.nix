{ ... }:
{
  imports = [
    ./neovim/options.nix
    ./neovim/keymaps.nix
    ./neovim/lsp.nix
    ./neovim/nix.nix
    ./neovim/go.nix
    ./neovim/telescope.nix
    ./neovim/git.nix
    ./neovim/ui.nix
    ./neovim/kubernetes.nix
    ./neovim/flux.nix
    ./neovim/kyverno.nix
    ./neovim/prometheus-operator.nix
    ./neovim/opentofu.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
