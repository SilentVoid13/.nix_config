{pkgs, ...}: {
  home.packages = with pkgs; [
    file
    binutils
    htop
    grc
    eza
    bat
    procs
    ripgrep
    dua
    jq
    just
    p7zip
    unzip
    usbutils
    lshw
    openvpn
    cloc
    trashy
    appimage-run
  ];
}
