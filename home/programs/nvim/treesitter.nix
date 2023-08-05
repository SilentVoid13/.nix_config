{
  config,
  pkgs,
  ...
}: let
in {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        ensureInstalled = ["c" "lua" "rust" "javascript" "typescript"];
      };
      treesitter-context = {
        enable = true;
      };
    };
  };
}
