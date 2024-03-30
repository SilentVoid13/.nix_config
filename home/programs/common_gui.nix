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
    spotify
    transmission-gtk
    chromium

    #discord
    vesktop
  ];
}
