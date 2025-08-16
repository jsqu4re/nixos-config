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
    icon = ../assets/icon/Screenshot_icon-icons.com_55819.png;
  };
in
screenshot.overrideAttrs (_: {
  cli = screenshot-cli;
  meta.mainProgram = "screenshot";
})
