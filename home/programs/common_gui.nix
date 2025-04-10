{
  pkgs,
  nixGLWrap,
  ...
}: {
  home.packages = with pkgs; [
    qalculate-gtk
    (nixGLWrap kdePackages.okular) # pdf viewer
    qimgv # image viewer
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
    obs-studio
    vlc
  ];
}
