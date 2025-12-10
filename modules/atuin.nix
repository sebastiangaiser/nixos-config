{ pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      # TODO not working due to `Existing file '/home/sebastian/.config/atuin/config.toml' would be clobbered`
      # enter_accept = false;
    };
  };
}
