{ nixpkgs, pkgs, home-manager, nixvim }:
let
  makeConfig = modules: home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    inherit modules;
  };

  nix-path = { ... }: {
    home.sessionVariables = {
    NIX_PATH = "nixpkgs=${nixpkgs}";
  };};

  modules = [
    nix-path
    nixvim.homeManagerModules.nixvim
  ];
in
{
  home = {
    jeising = makeConfig ([
      ./work.nix
      ./sway.nix
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
