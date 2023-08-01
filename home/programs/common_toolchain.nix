{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    clang
    clang-tools
    lua
    stylua
    lua-language-server
  ];
}
