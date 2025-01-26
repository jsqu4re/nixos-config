{ nixpkgs, home-manager, system }:
{
  "jeising" = home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs { inherit system; };
    modules = [
      ./work.nix
      ./cli.nix
      ./base.nix
    ];
  };
  "jsqu4re" = home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs { inherit system; };
    modules = [
      ./home.nix
      ./gui.nix
      ./cli.nix
      ./base.nix
    ];
  };
}
