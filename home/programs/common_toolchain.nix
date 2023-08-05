{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    clang
    lua
  ];
}
