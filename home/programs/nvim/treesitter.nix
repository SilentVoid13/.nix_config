{...}: {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          ensure_installed = ["c" "lua" "rust" "javascript" "typescript" "python" "markdown" "markdown_inline"];
        };
      };
      treesitter-context = {
        enable = true;
      };
    };
  };
}
