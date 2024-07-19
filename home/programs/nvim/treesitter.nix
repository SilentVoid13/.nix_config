{...}: {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          ensure_installed = ["c" "lua" "rust" "javascript" "typescript" "python" "nix" "markdown" "markdown_inline"];
          highlight.enable = true;
        };
      };
      treesitter-context = {
        enable = true;
      };
    };
  };
}
