{
  config,
  pkgs,
  ...
}: let
in {
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>fd" = {
          action = "git_files";
        };
        "<leader>ff" = {
          action = "find_files";
        };
        "<leader>fs" = {
          action = "live_grep";
        };
        "<leader>fb" = {
          action = "buffers";
        };
      };
    };
  };
}
