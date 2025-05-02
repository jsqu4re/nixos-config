final: prev: {
  screenshot = final.callPackage ./packages/screenshot.nix { };
  shutdown = final.callPackage ./packages/shutdown.nix { };
  vlc-blu-ray = final.callPackage ./packages/vlc-blu-ray.nix { };
  zen-browser = final.callPackage ./packages/zen-browser.nix { };
  share-cli = final.callPackage ./packages/share-cli.nix { };
}
