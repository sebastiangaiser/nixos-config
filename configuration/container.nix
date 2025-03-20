{ pkgs, ... }:{

  virtualisation = {
    docker = {
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
  };

  environment.systemPackages = with pkgs; [
    docker-buildx
    kind
  ];

  services.dockerRegistry = {
    enable = true;
    port = 5001;
  };
}
