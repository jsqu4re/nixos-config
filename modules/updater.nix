{ config, ... }:
{
  system.autoUpgrade = {
    enable = true;
    flake = "github.com:jsqu4re/nixos-config#${config.networking.hostName}";
    allowReboot = true;
  };
}
