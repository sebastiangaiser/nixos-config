{ lib, ... }:
{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        identityFile = "~/.ssh/id_ed25519";
        user = "root";
        addKeysToAgent = "yes";
        setEnv = {
          TERM = "xterm-256color";
        };
        extraOptions = {
          StrictHostKeyChecking = "accept-new";
          ConnectTimeout = "5";
        };
      };
    };
  };
}
