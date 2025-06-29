{ pkgs, ... }:{

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
