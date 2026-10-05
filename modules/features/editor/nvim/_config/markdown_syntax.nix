{ ... }:
let
in
{
  programs.nixvim = {
    plugins.render-markdown = {
      enable = true;
    };
    # plugins.markview = {
    #   enable = true;
    # };
  };
}
