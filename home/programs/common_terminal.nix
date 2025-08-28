{ pkgs, ... }:
{
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
    aria2
    rclone
    borgbackup

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
