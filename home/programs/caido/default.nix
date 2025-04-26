{ pkgs, ... }:
let
  version = "0.44.1";
in
{
  home.packages = with pkgs; [
    caido
    #(import ../../../pkgs/caido_gui.nix {inherit pkgs version;})
    #(import ../../../pkgs/caido_cli.nix {inherit pkgs version;})
  ];
}
