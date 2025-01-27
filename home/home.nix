{ lib, ... }:
{
  home = lib.mkDefault {
    username = "jsqu4re";
    homeDirectory = "/home/jsqu4re";
  };

  programs.git = {
    enable = true;
    userEmail = "johannes.jeising@gmail.com";
    userName = "Johannes Jeising";
  };
}
