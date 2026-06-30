{ ... }:
{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        IdentityFile = "~/.ssh/id_ed25519";
        User = "root";
        AddKeysToAgent = "yes";
        SetEnv = {
          TERM = "xterm-256color";
        };
        StrictHostKeyChecking = "accept-new";
        ConnectTimeout = "5";
      };
    };
  };
}
