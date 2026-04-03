{ ... }:
{
  flake.modules.nixos.wayland =
    { pkgs, ... }:
    {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      environment.sessionVariables = {
        MOZ_ENABLE_WAYLAND = 1;
        _JAVA_AWT_WM_NONREPARENTING = 1;
        NIXOS_OZONE_WL = 1;
      };

      xdg = {
        portal = {
          enable = true;
          extraPortals = [
            pkgs.xdg-desktop-portal-gnome
            pkgs.xdg-desktop-portal-gtk
          ];
          config = {
            common = {
              default = [
                "gnome"
                "gtk"
              ];
              "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
              "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
              "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
            };
          };
        };
      };
    };
}
