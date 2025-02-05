{ pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "jsqu4re";
      };
    };
  };

  hardware.graphics.enable = true;

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  security.pam.services.hyprlock = {};

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  users.users.jsqu4re = {
    isNormalUser = true;
    description = "Johannes";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nix.settings.trusted-users = [ "jsqu4re" "root" "@wheel" ];

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.variables.EDITOR = "vim";

  # Fix issues with electron based apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
