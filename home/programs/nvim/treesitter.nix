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
        ensureInstalled = ["c" "lua" "rust" "javascript" "typescript" "python" "markdown" "markdown_inline"];
      };
      treesitter-context = {
        enable = true;
      };
    };
  };
}
