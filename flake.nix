{
  description = "My Nix and NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    # nixosConfigurations = import ./hosts;
    # nixosModules = import ./modules;
    homeConfigurations = import ./home { inherit nixpkgs home-manager; system = "x86_64-linux"; };
    packages.x86_64-linux.homeManager = home-manager.defaultPackage.x86_64-linux;
  };
}
