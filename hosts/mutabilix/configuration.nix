{ pkgs, ... }:
# let
#   devices = [ "10de:1c8d" ];
# in
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "mutabilix";

  # Enable common container config files in /etc/containers
  # virtualisation.containers.enable = true;
  # virtualisation = {
  #   docker = {
  #     enable = true;

  #     # Create a `docker` alias for podman, to use it as a drop-in replacement
  #     # dockerCompat = true;

  #     # Required for containers under podman-compose to be able to talk to each other.
  #     # defaultNetwork.settings.dns_enabled = true;
  #   };
  # };

  # virtualisation.libvirtd = {
  #   enable = true;
  #   qemu.ovmf.enable = true;
  #   onBoot = "ignore";
  #   onShutdown = "shutdown";
  # };

  #  boot.kernelParams = [
  #    "intel_iommu=on"
  #    "iommu=pt"
  #    "vfio-pci.ids=${lib.concatStringsSep "," devices}"
  #  ];
  #
  #  boot.initrd.kernelModules = [
  #    "vfio_pci"
  #    "vfio"
  #    "vfio_iommu_type1"
  #  ];
  #
  #  boot.extraModprobeConfig = ''
  #    softdep nvidia pre: vfio-pci
  #    softdep drm pre: vfio-pci
  #    softdep nouveau pre: vfio-pci
  #  '';
  #
  #  boot.blacklistedKernelModules = [
  #    "nouveau"
  #    "nvidia"
  #    "nvidia_drm"
  #    "nvidia_modeset"
  #    "i2c_nvidia_gpu"
  #  ];
  #
  #  virtualisation.spiceUSBRedirection.enable = true;
  #
  #  systemd.tmpfiles.rules = [
  #    "f /dev/shm/looking-glass 0660 ${config.users.users.jsqu4re.name} libvirtd -"
  #  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  users.users.jsqu4re.extraGroups = [ "libvirtd" ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    virt-manager
    looking-glass-client
  ];

  services.onedrive.enable = true;

  system.stateVersion = "24.11";
}
