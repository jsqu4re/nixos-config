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
      sha256 = "sha256:1dkpphgv2h2qkf7j735g7l600plnv7906rrbw2chizvcgfm8j2rj";
    };
  };
in
shareCli.overrideAttrs (_: {
  cli = shareCli-cli;
  meta.mainProgram = "share-cli";
})
