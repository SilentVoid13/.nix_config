{
  pkgs,
  nixGLWrap,
  ...
}:
{
  home.packages = with pkgs; [
    qalculate-gtk
    (nixGLWrap kdePackages.okular) # pdf viewer
    qimgv # image viewer
    (nixGLWrap obsidian)
    mullvad-vpn
    onlyoffice-desktopeditors
    transmission_4-gtk
    #chromium
    #discord
    vesktop
    wdisplays

    # temp
    obs-studio
    #vlc
    #stremio
  ];
}
