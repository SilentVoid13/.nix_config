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
    python3
    appimage-run
    steam-run

    ## temp
    #quickemu
  ];
}
