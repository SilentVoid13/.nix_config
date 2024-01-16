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

      nvim-cmp = {
        enable = true;
        mapping = {
          "<C-b>" = {
            modes = ["i" "c"];
            action = "cmp.mapping.scroll_docs(-4)";
          };
          "<C-f>" = {
            modes = ["i" "c"];
            action = "cmp.mapping.scroll_docs(4)";
          };
          "<C-Space>" = {
            modes = ["i" "c"];
            action = "cmp.mapping.complete()";
          };
          "<C-n>" = {
            modes = ["i" "c"];
            action = "cmp.mapping.select_next_item()";
          };
          "<C-p>" = {
            modes = ["i" "c"];
            action = "cmp.mapping.select_prev_item()";
          };
          "<C-k>" = {
            modes = ["i"];
            action = ''
              function()
                  if require("luasnip").expand_or_jumpable() then
                      require("luasnip").expand_or_jump()
                  end
              end
            '';
          };
          "<C-j>" = {
            modes = ["i"];
            action = ''
              function()
                  if require("luasnip").jumpable(-1) then
                      require("luasnip").jump(-1)
                  end
              end
            '';
          };
          "<C-l>" = {
            modes = ["i"];
            action = ''
              function()
                  if require("luasnip").choice_active() then
                      require("luasnip").change_choice(1)
                  end
              end
            '';
          };
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<C-y>" = "cmp.config.disable";
          "<C-e>" = "cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() })";
        };
        sources = [
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {name = "buffer";}
          {name = "path";}
          {name = "copilot";}
        ];
        snippet.expand = "luasnip";
      };

      copilot-lua = {
        enable = true;
        panel.enabled = false;
        suggestion.enabled = false;
      };

      copilot-cmp = {
        enable = true;
      };

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

      cmp_luasnip = {
        enable = true;
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
