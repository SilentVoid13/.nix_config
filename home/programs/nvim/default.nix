{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./sets.nix
    ./maps.nix
    ./colors.nix
    ./lsp.nix
    ./harpoon.nix
    ./telescope.nix
    ./treesitter.nix

    ## formatter
    #./formatter.nix
    ./conform.nix

    ## git
    ./fugitive.nix
    ./gitsigns.nix
    ./neogit.nix

    ./debugprint.nix
    ./oil.nix
    ./comment.nix
    ./todo_comments.nix
    #./sov
    #./obsidian
  ];
}
