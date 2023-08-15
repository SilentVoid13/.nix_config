{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nmap
    sqlmap
    ffuf
    hashcat
  ];
}
