{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    file
    htop
    grc
    eza
    bat
    procs
    ripgrep
    dua
    jq
    topgrade
    trashy
    just
    p7zip
    unzip
    usbutils
    lshw
    openvpn
  ];
}
