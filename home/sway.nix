{ pkgs, ... }:
let
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    ${pkgs.grim}/bin/grim -g "${pkgs.slurp}" - | ${pkgs.wl-clipboard}/bin/wl-copy
  '';

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
    screenshot
    lockscreen
  ];

  fonts.fontconfig.enable = true;

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
