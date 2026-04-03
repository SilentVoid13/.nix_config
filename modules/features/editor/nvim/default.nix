{ inputs, ... }:
{
  flake.modules.homeManager.nvim =
    { ... }:
    {
      imports = [
        inputs.nixvim.homeModules.nixvim
        ./_config/sets.nix
        ./_config/maps.nix
        ./_config/colors.nix
        ./_config/lsp.nix
        ./_config/harpoon.nix
        ./_config/telescope.nix
        ./_config/treesitter.nix

        ## formatter
        #./_config/formatter.nix
        ./_config/conform.nix

        ## git
        ./_config/fugitive.nix
        ./_config/gitsigns.nix
        ./_config/neogit.nix

        ./_config/debugprint.nix
        ./_config/oil.nix
        ./_config/comment.nix
        ./_config/todo_comments.nix
        #./_config/sov
        #./_config/obsidian
      ];
    };
}
