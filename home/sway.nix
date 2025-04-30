{ pkgs, ... }:
let
  lockscreen = pkgs.writeShellScriptBin "lock-screen" ''
    swaylock -c 000000
  '';
in
{
  home.packages = [
    pkgs.chromium
    pkgs.gopass
    pkgs.dejavu_fonts
    pkgs.dmenu-rs
    pkgs.fd
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.powerline-fonts
    pkgs.screenshot
    lockscreen
  ];

  fonts.fontconfig.enable = true;
  programs.bash.enable = true;
  targets.genericLinux.enable = true;

  home.file = {
    ".config/sway/config".source = pkgs.substitute {
      src = ./config/sway/config;

      substitutions = [
        "--replace-fail"
        "dmenu"
        "${pkgs.dmenu-rs}/bin/dmenu_run"
      ];
    };
  };
}
