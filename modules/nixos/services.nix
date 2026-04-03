{ ... }:
{
  flake.modules.nixos.base-services =
    { pkgs, ... }:
    {
      services = {
        # VPN
        mullvad-vpn.enable = true;
        # Flatpak
        flatpak.enable = true;
        # Kanata keyboard remapping
        kanata = {
          enable = true;
          keyboards.mykeebs = {
            devices = [
              "/dev/input/by-id/usb-Kinesis_Kinesis_Adv360_360555127546-if01-event-kbd"
              "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
            ];
            extraDefCfg = "process-unmapped-keys yes";
            config = builtins.readFile ./_files/homerow.kbd;
          };
        };
        # File Manager
        gvfs.enable = true;
        tumbler.enable = true;
        udisks2.enable = true;
      };

      programs = {
        noisetorch.enable = true;
        thunar = {
          enable = true;
          plugins = with pkgs; [ thunar-volman ];
        };
      };
    };
}
