{ pkgs, modulesPath, ... }:
{
  imports = [
    ./hardware-configuration.nix
    "${toString modulesPath}/installer/cd-dvd/iso-image.nix"
  ];

  networking.hostName = "lavoro";

  # Enable CUPS to print documents.
  services.printing.enable = false;

  boot.loader.grub.efiInstallAsRemovable = true;

  # EFI booting
  isoImage.makeEfiBootable = true;

  # USB booting
  isoImage.makeUsbBootable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
