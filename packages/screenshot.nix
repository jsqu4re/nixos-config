{
  grim,
  lib,
  makeDesktopItem,
  runtimeShell,
  slurp,
  wl-clipboard,
  writeTextFile,
}:
let
  screenshot-cli = writeTextFile {
    name = "screenshot";
    text = ''
      #! ${runtimeShell}
      ${lib.getExe grim} -g "$(${lib.getExe slurp})" -| ${wl-clipboard}/bin/wl-copy
    '';
    executable = true;
    destination = "/bin/screenshot";
  };
  screenshot = makeDesktopItem {
    name = "screenshot";
    desktopName = "Screenshot";
    exec = "${lib.getExe screenshot-cli}";
    icon = builtins.fetchurl {
      url = "https://cdn.icon-icons.com/icons2/602/PNG/512/Screenshot_icon-icons.com_55819.png";
      sha256 = "sha256:1vnqv75m9xxjhm0d8ny76dvg9p3zz9cigj4ggz80z0ivnlzlhj94";
    };
  };
in
screenshot.overrideAttrs (_: {
  cli = screenshot-cli;
  meta.mainProgram = "screenshot";
})
