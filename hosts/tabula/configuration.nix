{ pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  virtualisation.libvirtd.enable = true;
  boot.kernelModules = [ "kvm-amd" "kvm-intel" "sg" ];

  networking.hostName = "tabula";

  users.users.jsqu4re.extraGroups = [ "qemu-libvirtd" "libvirtd" "video" "audio" "disk" "networkmanager" ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    quickemu
  ];

  services.onedrive.enable = true;

  system.stateVersion = "24.11";
}
