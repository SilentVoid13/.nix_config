{ ... }:
{
  flake.modules.homeManager.lldb =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        lldb
      ];
    };
}
