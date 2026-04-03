{ ... }:
{
  flake.modules.homeManager.wofi =
    { ... }:
    {
      programs.wofi = {
        enable = true;
        settings = {
          gtk_dark = true;
          insensitive = true;
        };
      };
    };
}
