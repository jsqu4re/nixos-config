{ lib, ... }:
{
  home = lib.mkDefault {
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
