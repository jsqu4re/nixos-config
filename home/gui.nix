{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zen-browser
    zen-browser.cli
    shutdown
    screenshot
    wl-clipboard
    nautilus
    # gimp
    # audacity
    # whatsapp-for-linux

    # fonts
    font-awesome
    liberation_ttf
    nerd-fonts.arimo

    gparted
    # games
    # itch
    # steam
  ];

  programs.kitty = {
    enable = true;
  };
}
