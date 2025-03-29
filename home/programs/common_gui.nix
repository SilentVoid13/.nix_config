{
  pkgs,
  nixGLWrap,
  ...
}: {
  home.packages = with pkgs; [
    qalculate-gtk
    (nixGLWrap kdePackages.okular)
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
