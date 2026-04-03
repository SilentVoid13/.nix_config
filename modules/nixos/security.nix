{ self, ... }:
{
  flake.modules.nixos.security =
    { pkgs, ... }:
    {
      security.polkit.enable = true;

      ## sway/niri lock
      security.pam.services.swaylock = { };

      services = {
        # Keyring
        gnome.gnome-keyring.enable = true;
        # Yubikey
        pcscd.enable = true;
      };

      services.udev.packages = with pkgs; [
        vial
      ];

      programs = {
        _1password = {
          enable = true;
        };
        _1password-gui = {
          enable = true;
          polkitPolicyOwners = [ "${self.myconf.username}" ];
        };
        dconf.enable = true;
      };
    };
}
