{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    htop
    grc
    exa
    bat
    procs
    ripgrep
    dua
    jq
    topgrade
    trashy
    just
  ];
}
