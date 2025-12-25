{ pkgs, ... }:
{
  home.packages = with pkgs; [
    file
    binutils
    grc
    eza
    bat
    ripgrep
    fd
    jq
    just

    ## archive
    p7zip
    unzip
    zip

    ## misc
    dua
    openvpn
    cloc
    trashy
    python3
    magic-wormhole
    rogcat
    spacer
    xlsclients

    ## monitoring
    s-tui
    procs

    ## hardware
    lshw
    dmidecode
    usbutils
    pciutils

    ## nixos utils
    appimage-run
    steam-run

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
