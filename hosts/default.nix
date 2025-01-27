{ nixosSystem, pkgs, grub2-theme, nixos-hardware, home-manager, nixvim, homeConfigs }:
let
  makeNixosSystem = machineModules: nixosSystem {
    system = "x86_64-linux";
    modules = [
      home-manager.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.jsqu4re = builtins.removeAttrs homeConfigs.jsqu4re.config [ "nixpkgs" ];
          backupFileExtension = "backup";
          sharedModules = [ nixvim.homeManagerModules.nixvim ];
        };
      }
      grub2-theme.nixosModules.default
    ] ++ machineModules;
  };
in
{
  tabula = makeNixosSystem [
    ./tabula/configuration.nix
  ];

  mutabilix = makeNixosSystem [
    ./mutabilix/configuration.nix
    nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];
}
