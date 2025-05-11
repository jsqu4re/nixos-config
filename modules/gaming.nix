{ ... }:
{
  nixpkgs.config.allowUnfree = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    protontricks.enable = true;
  };
}
