{
  pkgs,
  lib,
  ...
}:
let
  helpers = import ./helpers.nix { inherit lib; };
  ft = formatter: helpers.mkRaw "require('formatter.filetypes').${formatter}";
in
{
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
    extraPlugins = with pkgs.vimPlugins; [
      formatter-nvim
    ];

    extraConfigLua = helpers.mkPluginSetupCall "formatter" {
      logging = true;
      filetype = {
        rust = [
          (ft "rust.rustfmt")
        ];
        python = [
          (ft "python.black")
          (ft "python.isort")
        ];
        typescript = [
          (ft "typescript.prettier")
        ];
        javascript = [
          (ft "javascript.prettier")
        ];
        c = [
          (ft "c.clangformat")
        ];
        cpp = [
          (ft "cpp.clangformat")
        ];
        lua = [
          (ft "lua.stylua")
        ];
        sh = [
          (ft "sh.shfmt")
        ];
        toml = [
          (ft "toml.taplo")
        ];
        json = [
          (ft "json.jq")
        ];
        yaml = [
          (ft "yaml.yamlfmt")
        ];
        nix = [
          (ft "nix.alejandra")
        ];
        graphql = [
          (ft "graphql.prettier")
        ];
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>nf";
        action = "<cmd>FormatWrite<CR>";
      }
    ];
  };
}
