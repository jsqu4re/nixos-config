{ lib, pkgs, ... }:
{
  home = lib.mkForce {
    username = "jeising";
    homeDirectory = "/home/jeising";
  };

  programs.git = {
    enable = true;
    userEmail = "jeising@magazino.eu";
    userName = "Johannes Jeising";
  };

  targets.genericLinux.enable = true;
}
