{
  config,
  pkgs,
  ...
}: let
in {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          lspBuf = {
            gd = "definition";
            gD = "declaration";
            gT = "type_definition";
            gi = "implementation";
            gr = "references";
            K = "hover";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
          };
        };
        servers = {
          clangd = {enable = true;};
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
            settings = {
              procMacro = {
                enable = true;
              };
            };
          };
          tsserver = {enable = true;};
          ruff-lsp = {enable = true;};
          pylsp = {
            enable = true;
            settings.plugins = {
              jedi = {
                extra_paths = [
                  "${config.home.homeDirectory}/binaryninja/python"
                  "${config.home.homeDirectory}/binaryninja/python3"
                ];
              };
            };
          };
          lua-ls = {enable = true;};
        };
      };

      cmp = {
        enable = true;
        settings = {
          mapping = {
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            #"<C-k>" = ''function() if require("luasnip").expand_or_jumpable() then require("luasnip").expand_or_jump() end end'';
            #"<C-j>" = ''function() if require("luasnip").jumpable(-1) then require("luasnip").jump(-1) end end'';
            #"<C-l>" = ''function() if require("luasnip").choice_active() then require("luasnip").change_choice(1) end end'';
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<C-y>" = "cmp.config.disable";
            "<C-e>" = "cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() })";
          };
          sources = [
            {name = "nvim_lsp";}
            {name = "buffer";}
            {name = "path";}
            {name = "luasnip";}
            {name = "copilot";}
          ];
        };
      };

      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;

      copilot-cmp.enable = true;
      copilot-lua = {
        enable = true;
        panel.enabled = false;
        suggestion.enabled = false;
      };

      cmp_luasnip.enable = true;
      luasnip = {
        enable = true;
        # snippets are not that great
        #fromVscode = [
        #  {
        #    lazyLoad = true;
        #    paths = "${pkgs.vimPlugins.friendly-snippets}";
        #  }
        #];
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      friendly-snippets
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>dj";
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
      }
      {
        mode = "n";
        key = "<leader>dk";
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
      }
      {
        mode = "n";
        key = "<leader>dl";
        action = "<cmd>Telescope diagnostics<CR>";
      }
    ];
  };
}
