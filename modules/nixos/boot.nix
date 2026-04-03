{ inputs, ... }:
{
  flake.modules.nixos.boot =
    { pkgs, lib, ... }:
    {
      imports = [
        inputs.lanzaboote.nixosModules.lanzaboote
      ];
      # lanzaboote currently replaces the systemd-boot module
      boot = {
        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
        };
        loader.systemd-boot.enable = lib.mkForce false;
        # use bleeding edge kernel
        kernelPackages = pkgs.linuxPackages_latest;
        # kernelPackages = pkgs.linuxPackages_zen;
        supportedFilesystems = [ "ntfs" ];
      };
    };
}
