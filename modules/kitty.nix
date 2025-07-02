{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    font = {
      name = "JetBrains Mono";
      size = 10;
    };
    settings = {
      update_check_interval = 0;
    };
    shellIntegration.enableZshIntegration = true;
  };
}
