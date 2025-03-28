{
  writeTextFile,
  runtimeShell,
  makeDesktopItem,
}:
let
  shutdown-cli = writeTextFile {
    name = "shutdown";
    text = ''
      #! ${runtimeShell}
      shutdown now
    '';
    executable = true;
    destination = "/bin/shutdown-now";
  };
  shutdown = makeDesktopItem {
    name = "shutdown";
    desktopName = "shutdown now";
    exec = "${shutdown-cli}/bin/shutdown-now";
    icon = builtins.fetchurl {
      url = "https://png.pngtree.com/png-clipart/20230812/original/pngtree-shutdown-icon-isolated-shutdown-vector-picture-image_10452920.png";
      sha256 = "sha256:0ai35zl5jgvjlrq7b8i5l1a9ibb37jkk5wd48lxszr98xmiypmc4";
    };
  };
in
shutdown.overrideAttrs (_: {
  cli = shutdown-cli;
  meta.mainProgram = "shutdown";
})
