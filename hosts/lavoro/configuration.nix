{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "lavoro";

  # Enable CUPS to print documents.
  services.printing.enable = false;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
