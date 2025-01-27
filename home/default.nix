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
  jeising = makeConfig ([
    ./work.nix
  ] ++ basics );

  jsqu4re = makeConfig ([
    ./home.nix
    ./gui.nix
    ./hyprland.nix
  ] ++ basics );
  
  nixos-jsqu4re = { ... }: {
    imports = [
      ./home.nix
      ./gui.nix
      ./hyprland.nix
      ] ++ basics;
  };
}
