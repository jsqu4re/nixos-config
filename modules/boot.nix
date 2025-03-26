{ lib, ... }:
{
  boot.loader.grub = lib.mkDefault {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
  };

  boot.loader.grub2-theme = {
    enable = true;
    theme = "whitesur";
    icon = "white";
    screen = "1080p";
    splashImage = ../assets/background.png;
    footer = false;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
}
