{
  config,
  lib,
  pkgs,
  ...
}: let
  helpers = import ./helpers.nix {inherit lib;};
  md_link_pattern = helpers.mkRaw ''[[\(\k\| \|\/\|#\|-\)\+]]'';
in {
  programs.nixvim = {
    nixpkgs.useGlobalPackages = true;
    plugins = {
      lsp = {
        enable = true;
        capabilities = '''';
        onAttach =
          /*
          lua
          */
          ''
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_create_autocmd('BufWritePre', {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
                    end,
                })
            end
          '';
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
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
            settings = {
              check.command = "clippy";
            };
          };
          lua_ls = {enable = true;};
          #nil_ls = {enable = true;};
          nixd = {enable = true;};

          # python
          ruff = {enable = true;};
          /*
          pylsp = {
            enable = true;
            settings.plugins = {
              ruff.enabled = true;
              jedi = {
                extra_paths = [
                  "${config.home.homeDirectory}/binaryninja/python"
                  "${config.home.homeDirectory}/binaryninja/python3"
                  "${pkgs.lldb.lib}/lib/python3.11/site-packages"
                ];
              };
              rope.enabled = true;
            };
          };
          pylyzer = {
            enable = true;
            # TODO: remove this
            # https://github.com/NixOS/nixpkgs/issues/295735
            package = pkgs.emptyFile;
          };
          pyright = { enable = true; };
          */

          # js/ts
          ts_ls = {enable = true;};
          svelte = {enable = true;};
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
            {
              name = "nvim_lsp";
              option = {
                zk.keyword_pattern = md_link_pattern;
                sov.keyword_pattern = md_link_pattern;
                markdown_oxide.keyword_pattern = md_link_pattern;
              };
            }
            {name = "buffer";}
            {name = "path";}
            {name = "luasnip";}
            {name = "copilot";}
          ];
          snippet = {
            expand =
              /*
              lua
              */
              ''
                function(args)
                    require('luasnip').lsp_expand(args.body)
                end'';
          };
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      copilot-cmp.enable = true;
      copilot-lua = {
        enable = true;
        settings = {
          suggestion.enabled = false;
          panel.enabled = false;
        };
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

      /*
      coq-nvim = {
        enable = true;
        #installArtifacts = true;
        autoStart = true;
      };
      */
    };

    extraPlugins = with pkgs.vimPlugins; [
      #friendly-snippets
      plenary-nvim
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>dd";
        action = "<cmd>lua vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR })<CR>";
      }
      {
        mode = "n";
        key = "<leader>dw";
        action = "<cmd>lua vim.diagnostic.setqflist({severity = { min = vim.diagnostic.severity.WARN }})<CR>";
      }
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
    extraConfigLua = ''
      -- require("lspconfig").markdown_oxide.setup({})
    '';
  };
}
