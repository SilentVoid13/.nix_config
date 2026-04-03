{ ... }:
let
in
{
  programs.nixvim = {
    plugins.neogit = {
      enable = true;
      settings = {
        disable_line_numbers = false;
        disable_relative_line_numbers = false;
        mappings.status = {
          # like in fugitive
          "=" = "Toggle";
        };
      };
    };
    plugins.diffview = {
      enable = true;
    };
  };
}
