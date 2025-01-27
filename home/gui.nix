{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zen-browser
    wl-clipboard
    nautilus
    # gimp
    # audacity
    # whatsapp-for-linux

    # fonts
    font-awesome
    liberation_ttf
    nerd-fonts.arimo

    # games
    # itch
    # steam
  ];

  programs.kitty = {
    enable = true;
  };
}
