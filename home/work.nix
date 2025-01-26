{ ... }:
{
  home.username = "jeising";
  home.homeDirectory = "/home/jeising";

  programs.git = {
    enable = true;
    userEmail = "jeising@magazino.eu";
    userName = "Johannes Jeising";
  };
}
