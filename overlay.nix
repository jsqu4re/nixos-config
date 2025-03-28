final: prev: {
  shutdown = final.callPackage ./packages/shutdown.nix { };
  zen-browser = final.callPackage ./packages/zen-browser.nix { };
  vlc-blu-ray = final.callPackage ./packages/vlc-blu-ray.nix { };
}
