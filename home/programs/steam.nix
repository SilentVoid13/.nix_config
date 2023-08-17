{
  config,
  pkgs,
  ...
}: let
in {
    home.packages = with pkgs; [
        steam
        mangohud
        gamescope
        gamemode
    ];

    # TODO: install proton-ge?
}
