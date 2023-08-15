{
  lib,
  config,
  pkgs,
  ...
}: let
in {
  programs.nixvim = {
    enable = true;

    maps = {
      visual = {
        # Copy to clipboard
        "<leader>cp" = "\"+y<CR>";
      };
    };
  };
}
