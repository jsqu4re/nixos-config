{ vlc, libbluray }:
let
  libbluray' = libbluray.override {
    withAACS = true;
    withBDplus = true;
  };
in
vlc.override { libbluray = libbluray'; }
