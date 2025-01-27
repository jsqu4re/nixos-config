{
  description = "My Nix and NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.home-manager.follows = "home-manager";
    grub2-theme.url = "github:vinceliuice/grub2-themes";
    grub2-theme.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, grub2-theme, nixos-hardware, home-manager, nixvim, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ self.overlays.default ];
    };
    nixosSystem = nixpkgs.lib.nixosSystem;
    homeConfigActivationPackages = builtins.mapAttrs (_name: homeConfig: homeConfig.activationPackage) self.homeConfigurations;
    nixosMachinePackages = builtins.mapAttrs (_name: nixosConfig: nixosConfig.config.system.build.toplevel) self.nixosConfigurations;
  in
  {
    legacyPackages.${system} = pkgs;
    nixosConfigurations = import ./hosts { inherit nixosSystem grub2-theme nixos-hardware home-manager nixvim; inherit (self) overlays homeConfigurations; };
    nixosModules = import ./modules { };
    homeConfigurations = import ./home { inherit pkgs home-manager nixvim; };

    packages.${system} = homeConfigActivationPackages // nixosMachinePackages // { inherit (pkgs) zen-browser; inherit home-manager nixosSystem nixpkgs; };

    overlays.default = import ./overlay.nix;
  };
}
