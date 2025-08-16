{ config, ... }:
{
  system.autoUpgrade = {
    enable = true;
    flake = "github:jsqu4re/nixos-config#${config.networking.hostName}";
    allowReboot = true;
  };
}
