{
  config,
  pkgs,
  ...
}: let
in {
  programs.nixvim = {
    plugins.harpoon = {
      enable = true;
      keymapsSilent = true;
      keymaps = {
        addFile = "<leader>m";
        toggleQuickMenu = "<leader>'";
        navFile = {
          "1" = "'a";
          "2" = "'s";
          "3" = "'d";
          "4" = "'f";
          "5" = "'q";
          "6" = "'w";
          "7" = "'e";
          "8" = "'r";
        };
      };
    };
  };
}
