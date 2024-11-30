{
  pkgs,
  nixGLWrap,
  ...
}: {
  home.packages = with pkgs; [
    (nixGLWrap wdisplays)
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

    # temp
    spotify
    tidal-hifi
    obs-studio
    vlc
    stretchly
  ];
}
