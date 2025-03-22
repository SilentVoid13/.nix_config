{
  pkgs,
  pkgs-stable,
  stylix,
  config,
  ...
}: {
  imports = [
    stylix.homeManagerModules.stylix
  ];
  stylix = {
    enable = true;
    #polarity = "dark";
    image = config.lib.stylix.pixel "base0A";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

    #base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    override = {
      scheme = "custom-tokyo-night-dark";
      base00 = "000000";
      base04 = "FFFFFF"; # dark white
      base05 = "FFFFFF"; # white
      base06 = "FFFFFF"; # middle white
      base07 = "FFFFFF"; # bright white
    };
    #base16Scheme = {
    #  base00 = "000000"; # ---- black
    #  base01 = "202020"; # --- black
    #  base02 = "202020"; # -- black
    #  base03 = "404040"; # - black
    #  base04 = "FFFFFF"; # dark white
    #  base05 = "FFFFFF"; # white
    #  base06 = "FFFFFF"; # middle white
    #  base07 = "FFFFFF"; # bright white

    #  base08 = "EF2F27"; # red
    #  base09 = "FF5F00"; # orange
    #  base0A = "FBB829"; # yellow
    #  base0B = "519F50"; # green
    #  base0C = "0AAEB3"; # cyan
    #  base0D = "2C78BF"; # blue
    #  base0E = "E02C6D"; # purple
    #  base0F = "2BE4D0"; # brown
    #};

    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      # NOTE: bibata-cursors is currently broken
      # https://github.com/ful1e5/Bibata_Cursor/issues/173
      #package = pkgs.bibata-cursors;
      #name = "Bibata-Modern-Classic";
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
        name = "DejaVuSansM Nerd Font";
        package = pkgs.nerd-fonts.dejavu-sans-mono;
      };
    };

    targets = {
      waybar.enable = true;
      nixvim.enable = false;
      foot.enable = false;
      firefox.profileNames = ["0"];
    };
  };
}
