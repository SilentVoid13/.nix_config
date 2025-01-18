{
  pkgs,
  nixGLWrap,
  ...
}: {
  home.packages = with pkgs; [
    qalculate-gtk
    (nixGLWrap okular)
    (nixGLWrap obsidian)
    mullvad-vpn
    onlyoffice-bin
    transmission_4-gtk
    chromium
    #discord
    vesktop
    gnome-pomodoro
    stremio
    nwg-displays

    # temp
    spotify
    tidal-hifi
    obs-studio
    vlc
    stretchly
  ];
}
