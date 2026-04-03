{ ... }:
{
  flake.modules.homeManager.mpv =
    { pkgs, ... }:
    {
      programs.mpv = {
        enable = true;
        package = pkgs.mpv;
      };
    };
}
