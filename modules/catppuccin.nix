{ pkgs, ... }:
{
  # https://nix.catppuccin.com/search/
  catppuccin = {
    bat = {
      enable = true;
      flavor = "mocha";
    };
    ghostty = {
      enable = true;
      flavor = "mocha";
    };
    k9s = {
      enable = true;
      flavor = "mocha";
    };
    kitty = {
      enable = true;
      flavor = "mocha";
    };
    nvim = {
      enable = true;
      flavor = "mocha";
    };
    thunderbird = {
      enable = true;
      flavor = "latte";
    };
    tmux = {
      enable = true;
      extraConfig = ''
        set -g @catppuccin_status_modules_right "application session user host date_time"
      '';
      flavor = "mocha";
    };
    vscode.profiles.default = {
      enable = true;
      flavor = "mocha";
    };
    zsh-syntax-highlighting = {
      enable = true;
      flavor = "mocha";
    };
  };
}
