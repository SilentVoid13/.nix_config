{ ... }:
{
  flake.modules.homeManager.caido =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        caido
      ];
    };
}
