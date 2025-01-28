{ pkgs, home-manager, nixvim }:
let
  makeConfig = modules: home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    inherit modules;
  };

  modules = [
    nixvim.homeManagerModules.nixvim
  ];
in
{
  home = {
    jeising = makeConfig ([
      ./work.nix
      ./gui.nix
      ./cli.nix
      ./base.nix
    ] ++ modules );

    jsqu4re = makeConfig ([
      ./home.nix
      ./gui.nix
      ./cli.nix
      ./base.nix
    ] ++ modules );
  };

  nixos = {
    jsqu4re = { ... }: {
      imports = [
        ./home.nix
        ./gui.nix
        ./hyprland.nix
        ./cli.nix
        ./base.nix
      ] ++ modules;
    };
  };
}
