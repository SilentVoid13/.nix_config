{
  config,
  pkgs,
  ...
}: let
in {
    home.packages = with pkgs; [
        steam
        steam-run
        mangohud
        gamescope
        gamemode
    ];

    # TODO: install proton-ge?
}
