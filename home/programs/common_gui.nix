{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    webcord
    qalculate-gtk
    okular
    networkmanagerapplet
    obsidian
    onlyoffice-bin
  ];
}
