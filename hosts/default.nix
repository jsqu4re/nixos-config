{ nixosSystem, grub2-theme, nixos-hardware, home-manager, homeNixos, overlays }:
let
  makeNixosSystem = machineModules: nixosSystem {
    system = "x86_64-linux";
    modules = [
      { nixpkgs.overlays = [ overlays.default ]; }
      home-manager.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.jsqu4re = homeNixos.jsqu4re;
          backupFileExtension = "backup";
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
    ../modules/gaming.nix
    ../modules/bluetooth.nix
    nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];
}
