{pkgs, ...}: {
  home.packages = with pkgs; [
    black
    isort
    nodePackages_latest.prettier
    clang-tools
    jq
    alejandra
    stylua
    shfmt
    yamlfmt
    taplo
  ];

  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      formattersByFt = {
        rust = [
          "rustfmt"
        ];
        python = [
          "black"
          "isort"
        ];
        typescript = [
          "prettier"
        ];
        javascript = [
          "prettier"
        ];
        c = [
          "clang-format"
        ];
        cpp = [
          "clang-format"
        ];
        lua = [
          "stylua"
        ];
        sh = [
          "shfmt"
        ];
        toml = [
          "taplo"
        ];
        json = [
          "jq"
        ];
        yaml = [
          "yamlfmt"
        ];
        nix = [
          "alejandra"
        ];
        graphql = [
          "prettier"
        ];
      };
      formatters = {
        clang-format = {
          prepend_args = [
            "--fallback-style=webkit"
          ];
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>nf";
        action.__raw = "function() require('conform').format({ bufnr = vim.api.nvim_get_current_buf() }); vim.api.nvim_command('write') end";
      }
    ];
  };
}