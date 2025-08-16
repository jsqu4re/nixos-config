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
    machineModules: home:
    nixosSystem {
      system = "x86_64-linux";
      modules = [
        { nixpkgs.overlays = [ overlays.default ]; }
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.jsqu4re = home;
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
  ] homeNixos.jsqu4re;

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
  ] homeNixos.jsqu4re;

  lavoro = makeNixosSystem [
    ./lavoro/configuration.nix
    ../modules/user.nix
    ../modules/gaming.nix
    ../modules/bluetooth.nix
    ../modules/audio.nix
    ../modules/networking.nix
    ../modules/localization.nix
    ../modules/boot.nix
  ] homeNixos.jsqu4re;

  mons = makeNixosSystem [
    ./mons/configuration.nix
    ../modules/tailscale.nix
    ../modules/updater.nix
  ] homeNixos.jsqu4re-cli;
}
