{ ... }:
{
  flake.modules.homeManager.common-gui =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        qalculate-gtk
        kdePackages.okular # pdf viewer
        qimgv # image viewer
        obsidian
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
    };
}
