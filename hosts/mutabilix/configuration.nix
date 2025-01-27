{ config, pkgs, lib, ... }:
let
  devices = [ "10de:1c8d" ];
in
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub = {
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
    # bootMenuConfig = ./config/boot/theme-4k.txt;
    splashImage = ./../../assets/background.png;
    footer = false;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  # boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Enable OpenGL
  hardware.graphics.enable = true;

  # Load nvidia driver for Xorg and Wayland
  # services.xserver.videoDrivers = ["nvidia"];

  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   powerManagement.enable = true;
  #   powerManagement.finegrained = false;
  #   open = false;
  #   nvidiaSettings = true;
  #   package = config.boot.kernelPackages.nvidiaPackages.beta;
  # };

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };
  
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "jsqu4re";
      };
    };
  };

  security.pam.services.hyprlock = {};

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  users.users.jsqu4re = {
    isNormalUser = true;
    description = "Johannes";
    extraGroups = [ "networkmanager" "libvirtd" "wheel" ];
    packages = with pkgs; [
      pavucontrol
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    virt-manager
    looking-glass-client
  ];

  environment.variables.EDITOR = "vim";

  # Fix issues with electron based apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.onedrive.enable = true;

  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "192.168.1.145" ];

  services.openssh.enable = true;
  networking.firewall.enable = true;

  system.stateVersion = "24.11";
}
