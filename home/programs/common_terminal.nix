{pkgs, ...}: {
  home.packages = with pkgs; [
    file
    binutils
    htop
    #nvtopPackages.full
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
    zip
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
