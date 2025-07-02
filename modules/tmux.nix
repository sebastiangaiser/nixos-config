{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.nord;
      }
    ];
    shell = "${pkgs.zsh}/bin/zsh";
  };
}
