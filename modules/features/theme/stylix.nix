{ inputs, ... }:
{
  flake.modules.nixos.stylix =
    { pkgs, ... }:
    {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];

      stylix = {
        enable = true;
        autoEnable = true;
        enableReleaseChecks = false;
        polarity = "dark";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
        image = pkgs.runCommand "pixel-wallpaper.png" { } ''
          ${pkgs.lib.getExe' pkgs.imagemagick "convert"} xc:"#FBB829" png32:$out
        '';
        override = {
          scheme = "custom-tokyo-night-dark";
          base00 = "000000";
          base04 = "FFFFFF";
          base05 = "FFFFFF";
          base06 = "FFFFFF";
          base07 = "FFFFFF";
        };
        cursor = {
          package = pkgs.phinger-cursors;
          name = "phinger-cursors-dark";
          size = 24;
        };
        fonts = {
          sizes = {
            terminal = 14;
          };
          monospace = {
            name = "Iosevka Nerd Font Mono";
            package = pkgs.nerd-fonts.iosevka;
          };
          sansSerif = {
            name = "IBM Plex Sans";
            package = pkgs.ibm-plex;
          };
        };
      };
    };

  flake.modules.homeManager.stylix =
    { pkgs, config, ... }:
    {
      imports = [
        inputs.stylix.homeModules.stylix
        inputs.niri.homeModules.stylix
      ];

      stylix = {
        enable = true;
        autoEnable = true;
        enableReleaseChecks = false;
        polarity = "dark";
        image = config.lib.stylix.pixel "base0A";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
        override = {
          scheme = "custom-tokyo-night-dark";
          base00 = "000000";
          base04 = "FFFFFF";
          base05 = "FFFFFF";
          base06 = "FFFFFF";
          base07 = "FFFFFF";
        };
        cursor = {
          package = pkgs.phinger-cursors;
          name = "phinger-cursors-dark";
          size = 24;
        };
        fonts = {
          sizes = {
            terminal = 14;
          };
          monospace = {
            name = "Iosevka Nerd Font Mono";
            package = pkgs.nerd-fonts.iosevka;
          };
          sansSerif = {
            name = "IBM Plex Sans";
            package = pkgs.ibm-plex;
          };
        };
        targets = {
          waybar.enable = true;
          nixvim.enable = false;
          foot.enable = false;
        };
      };
    };
}
