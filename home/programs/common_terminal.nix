{ pkgs, ... }:
{
  home.packages = with pkgs; [
    file
    binutils
    grc
    eza
    bat
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
    magic-wormhole
    rogcat
    fd

    ## monitoring
    s-tui
    procs

    ## hardware
    lshw
    dmidecode
    usbutils
    pciutils

    ## temp
    #quickemu
  ];

  xdg = {
    enable = true;
    configFile."rustfmt/rustfmt.toml".text = ''
      edition = "2024"
    '';
  };
}
