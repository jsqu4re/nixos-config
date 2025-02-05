{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];


  virtualisation.libvirtd.enable = true;
  boot.kernelModules = [ "kvm-amd" "kvm-intel" "sg" ];

  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

  networking.hostName = "tabula";

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  
  users.users.jsqu4re.extraGroups = [ "qemu-libvirtd" "libvirtd" "video" "audio" "disk" "networkmanager" ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    quickemu
  ];

  services.onedrive.enable = true;

  system.stateVersion = "24.11";
}
