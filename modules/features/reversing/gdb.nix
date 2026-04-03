{ ... }:
{
  flake.modules.homeManager.gdb =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gdb
        #pwndbg
      ];
    };
}
