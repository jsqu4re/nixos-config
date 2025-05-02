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
      ${lib.getExe chromium} 127.0.0.1:8080
      ${lib.getExe gotty} -w bash
    '';
    executable = true;
    destination = "/bin/share-cli";
  };
  shareCli = makeDesktopItem {
    name = "share-cli";
    desktopName = "Share CLI";
    exec = "${lib.getExe shareCli-cli}";
    icon = builtins.fetchurl {
      url = "https://cdn4.iconfinder.com/data/icons/share-2/32/308-01-1024.png";
      sha256 = "sha256:13w7y98kr9p8wb3v28qvhd5jgx7104s0lknfjc6f16anbqfkk55y";
    };
  };
in
shareCli.overrideAttrs (_: {
  cli = shareCli-cli;
  meta.mainProgram = "share-cli";
})
