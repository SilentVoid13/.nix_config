{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    steam-run
    mangohud
    gamescope
    gamemode
    # proton-ge
    protonup
  ];
}
