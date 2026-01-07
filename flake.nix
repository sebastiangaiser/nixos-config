{
  description = "NixOS configuration flake";

  inputs = {
    catppuccin.url = "github:catppuccin/nix/release-25.11";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    sops-nix.url = "github:Mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
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
      plasma-manager,
      home-manager,
      nixos-hardware,
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
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.sebastian = {
                  imports = [
                    (import ./home.nix {unstable = nixpkgs-unstable.legacyPackages.${system};})
                    catppuccin.homeModules.catppuccin
                  ];
                };
              };

              home-manager.sharedModules = [
                plasma-manager.homeModules.plasma-manager
              ];
            }
          ];
        };
      };
    };
}
