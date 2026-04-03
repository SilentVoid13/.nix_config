{ ... }:
{
  flake.modules.nixos.virtualisation =
    { pkgs, ... }:
    {
      # containers / virtualisation
      virtualisation.docker = {
        enable = true;
        liveRestore = false;
      };
      programs.firejail.enable = true;

      # make non-nixos things slightly less painful
      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          stdenv.cc.cc.lib
          zlib
        ];
      };

      # make non-nixos things slightly less painful
      services.envfs.enable = true;
    };
}
