{
  config,
  pkgs,
  specialArgs,
  ...
}: let 
    nixGLWrap = specialArgs.nixGLWrap;
in {
  home.packages = with pkgs; [
    discord
    qalculate-gtk
    (nixGLWrap okular)
    (nixGLWrap obsidian)
    mullvad-vpn
    onlyoffice-bin
    spotify
    transmission-gtk
    chromium
  ];
}
