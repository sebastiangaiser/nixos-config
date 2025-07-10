{ pkgs, ... }:
{
  # https://nix.catppuccin.com/search/
  catppuccin = {
    k9s = {
      enable = true;
      flavor = "mocha";
    };
    bat = {
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
    tmux = {
      enable = true;
      extraConfig = ''
        set -g @catppuccin_status_modules_right "application session user host date_time"
      '';
      flavor = "mocha";
    };
  };
}
