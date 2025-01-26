{ pkgs, home-manager, nixvim }:
let
  basic-profiles = [
    ./cli.nix
    ./base.nix
  ];
  modules = [
    nixvim.homeManagerModules.nixvim
  ];
  basics = basic-profiles ++ modules;
  makeConfig = modules: home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    inherit modules;
  };
in
{
  jeising = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = [
      ./work.nix
    ] ++ basics;
  };
  jsqu4re = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = [
      ./home.nix
      ./gui.nix
      ./hyprland.nix
    ] ++ basics;
  };
}
