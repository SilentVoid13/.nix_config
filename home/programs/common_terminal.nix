{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
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
    peazip
    unzip
  ];
}
