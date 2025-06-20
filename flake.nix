{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url          = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url   = "github:nixos/nixpkgs/master";
    nixos-hardware.url   = "github:nixos/nixos-hardware";
    sops-nix.url         = "github:Mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-master,
    sops-nix,
    plasma-manager,
    home-manager,
    nixos-hardware,
    ...
  }: {
    nixosConfigurations = {
      dell-xps13 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-hardware.nixosModules.dell-xps-13-7390
          ./configuration.nix

	        home-manager.nixosModules.home-manager{
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sebastian = {
              imports = [ ./home.nix ];
            };

	          home-manager.sharedModules = [
              plasma-manager.homeManagerModules.plasma-manager
            ];
          }
        ];
      };
    };
  };
}
