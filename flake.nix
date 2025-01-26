{
  description = "My Nix and NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.home-manager.follows = "home-manager";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ self.overlays.default ];
    };
    homeConfigs = builtins.mapAttrs (_name: config: config.activationPackage) self.homeConfigurations;
  in
  {
    nixosConfigurations = import ./hosts { inherit pkgs; };
    nixosModules = import ./modules { };
    homeConfigurations = import ./home { inherit pkgs home-manager nixvim; };

    packages.${system} = homeConfigs // { inherit (pkgs) zen-browser; };

    overlays.default = import ./overlay.nix;
  };
}
