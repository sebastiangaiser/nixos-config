{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    catppuccin = {
      url = "github:catppuccin/nix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Private work-specific config — internal hostnames/identifiers live here,
    # out of this public repo. Local path input (flake = false: plain .nix
    # files), so nothing is fetched over the network and the real host names
    # never land in this repo or its lock file.
    work = {
      url = "path:/home/sebastian/nixos-config-work";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixpkgs-master,
      sops-nix,
      catppuccin,
      nixvim,
      plasma-manager,
      home-manager,
      nixos-hardware,
      work,
      ...
    }:
    {
      nixosConfigurations = let system = "x86_64-linux"; in{
        framework13 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            nixos-hardware.nixosModules.framework-amd-ai-300-series
            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              nixpkgs.config.allowUnfree = true;

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "bak";
                users.sebastian = {
                  imports = [
                    (import ./home.nix {
                      unstable = import nixpkgs-unstable {
                        inherit system;
                        config.allowUnfree = true;
                      };
                    })
                    catppuccin.homeModules.catppuccin
                    # Private work-specific config (see the `work` flake input).
                    "${work}/work.nix"
                  ];
                };
              };

              home-manager.sharedModules = [
                nixvim.homeModules.nixvim
                plasma-manager.homeModules.plasma-manager
              ];
            }
          ];
        };
      };
    };
}
