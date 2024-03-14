{
  lib,
  config,
  pkgs,
  ...
}: let
in {
  imports = [
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
    #./obsidian
  ];
}
