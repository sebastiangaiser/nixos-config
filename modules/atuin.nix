{ pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      # Disable syncing shell history to atuin.sh cloud
      auto_sync = false;
      # Execute command immediately on Enter instead of just inserting it
      enter_accept = false;
    };
  };
}
