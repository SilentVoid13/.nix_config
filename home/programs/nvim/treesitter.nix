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
        ensureInstalled = ["c" "lua" "rust" "javascript" "typescript" "markdown" "markdown_inline"];
      };
      treesitter-context = {
        enable = true;
      };
    };
  };
}
