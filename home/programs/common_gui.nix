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
    transmission-gtk
    chromium
    #discord
    vesktop
    gnome-pomodoro
    stremio

    # temp
    spotify
    vlc
    tidal-hifi
  ];
}
