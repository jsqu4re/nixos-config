{
  nixpkgs,
  grub2-theme,
  nixos-hardware,
  home-manager,
  homeNixos,
  overlays,
}:
let
  nixosSystem = nixpkgs.lib.nixosSystem;
  makeNixosSystem =
    machineModules:
    nixosSystem {
      system = "x86_64-linux";
      modules = [
        { nixpkgs.overlays = [ overlays.default ]; }
        home-manager.nixosModules.home-manager
        {
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
    ../modules/user.nix
    ../modules/gaming.nix
    ../modules/nvidia.nix
    ../modules/audio.nix
    ../modules/networking.nix
    ../modules/localization.nix
    ../modules/boot.nix
    ../modules/bluetooth.nix
    ../modules/tailscale.nix
  ];

  mutabilix = makeNixosSystem [
    ./mutabilix/configuration.nix
    ../modules/user.nix
    ../modules/gaming.nix
    ../modules/bluetooth.nix
    ../modules/audio.nix
    ../modules/networking.nix
    ../modules/localization.nix
    ../modules/boot.nix
    ../modules/tailscale.nix
    # image.modules.iso "${toString modulesPath}/installer/cd-dvd/installation-cd-base.nix"
    nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];

  lavoro = makeNixosSystem [
    ./mutabilix/configuration.nix
    ../modules/user.nix
    ../modules/gaming.nix
    ../modules/bluetooth.nix
    ../modules/audio.nix
    # ../modules/networking.nix
    ../modules/localization.nix
    ../modules/boot.nix
    ({ lib, ... }: { networking.hostName = lib.mkForce "lavoro"; })
    ({ modulesPath, ... }: { imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-base.nix" ]; })
  ];
}
