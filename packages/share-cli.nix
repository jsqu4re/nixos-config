{
  lib,
  makeDesktopItem,
  runtimeShell,
  gotty,
  chromium,
  writeTextFile,
}:
let
  shareCli-cli = writeTextFile {
    name = "share-cli";
    text = ''
      #! ${runtimeShell}
      ${lib.getExe chromium} 127.0.0.1:8088
      ${lib.getExe gotty} -p 8088 -w bash
    '';
    executable = true;
    destination = "/bin/share-cli";
  };
  shareCli = makeDesktopItem {
    name = "share-cli";
    desktopName = "Share CLI";
    exec = "${lib.getExe shareCli-cli}";
    icon = ../assets/icon/share-cli.png;
  };
in
shareCli.overrideAttrs (_: {
  cli = shareCli-cli;
  meta.mainProgram = "share-cli";
})
