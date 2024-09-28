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
    openvpn
    cloc
    trashy
    python3
    appimage-run
    steam-run

    ## hardware
    lshw
    dmidecode
    usbutils

    ## temp
    #quickemu
  ];
}
