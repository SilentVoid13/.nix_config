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
    chromium
    #discord
    vesktop
    nwg-displays

    # temp
    obs-studio
    #vlc
    #stremio
  ];
}
