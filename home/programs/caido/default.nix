{pkgs, ...}: let
  version = "0.39.0";
in {
  home.packages = [
    (import ./gui_pkg.nix {inherit pkgs version;})
    (import ./cli_pkg.nix {inherit pkgs version;})
  ];
}
