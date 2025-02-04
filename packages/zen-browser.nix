{ writeTextFile, runtimeShell, nix, unixtools, makeDesktopItem }:
let
  zen = writeTextFile {
    name = "zen-browser";
    text = ''
      #! ${runtimeShell}
      ${unixtools.ping}/bin/ping -c 1 github.com > /dev/null 2>&1
      if [ $? -ne 0 ]
      then
        ${nix}/bin/nix run github:0xc000022070/zen-browser-flake --offline
      else
        ${nix}/bin/nix build github:0xc000022070/zen-browser-flake -o /nix/var/nix/gcroots/per-user/jsqu4re/zen &
        ${nix}/bin/nix run github:0xc000022070/zen-browser-flake --offline
      fi
    '';
    executable = true;
    destination = "/bin/zen";
  };
  zen-browser = makeDesktopItem {
    name = "zen";
    desktopName = "Zen Browser";
    exec = "${zen}/bin/zen"; 
    icon = builtins.fetchurl {
      url = "https://cdn2.steamgriddb.com/icon/682d409f010b6adafa853f2111b6d49a.png";
      sha256 = "sha256:05wf4m4nwhilfi4i0mg7d9n6cb8cqgx3kwra4075r69n83723lci";
    };
  };
in
zen-browser.overrideAttrs (_: {
  cli = zen;
  meta.mainProgram = "zen";
})
