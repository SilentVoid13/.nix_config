{pkgs, ...}: let
  version = "0.41.0";
in {
  home.packages = [
    (import ../../../pkgs/caido_gui.nix {inherit pkgs version;})
    (import ../../../pkgs/caido_cli.nix {inherit pkgs version;})
  ];
}
