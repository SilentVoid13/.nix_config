{nixvim, ...}: {
  imports = [
    nixvim.homeManagerModules.nixvim
    ./sets.nix
    ./maps.nix
    ./colors.nix
    ./lsp.nix
    ./harpoon.nix
    ./telescope.nix
    ./treesitter.nix
    ./formatter.nix
    ./fugitive.nix
    ./debugprint.nix
    ./oil.nix
    ./todo_comments.nix
    ./sov
    #./obsidian
  ];
}
