{ pkgs, ... }:
{
  imports = [
    ./nixvim.nix
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    # Unnecessary
    cmatrix
    neofetch
    
    # Files
    nnn # terminal file manager
    gdu # better ncdu
    tldr
    zip
    xz
    unzip
    p7zip
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    cowsay
    file
    which
    tree
    zstd
    gnupg

    # Nix
    nixpkgs-fmt
    nix-output-monitor
    
    # Viewer
    glow # markdown previewer in terminal
    bat
    silver-searcher
    chafa

    # Monitoring
    htop
    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  programs.git = {
    aliases = {
      co = "checkout";
      st = "status";
      p = "push";
      c = "commit";
      cm = "commit -m";
      aa = "add --all";
    };
  };
}
