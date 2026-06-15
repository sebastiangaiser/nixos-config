{ pkgs, ... }:
{

  virtualisation = {
    docker = {
      autoPrune = {
        dates = "weekly";
        flags = [
          "--all"
          "--volumes"
        ];
      };
      enable = false;
      storageDriver = "btrfs";
      rootless = {
        enable = false;
        setSocketVariable = true;
      };
    };
    podman = {
      enable = true;
      dockerCompat = true;
    };
    containers.containersConf.settings = {
      network = {
        default_rootless_network_cmd = "slirp4netns";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    docker-buildx
    kind
    podman-compose
  ];

  services.dockerRegistry = {
    enable = true;
    port = 5001;
  };
}
