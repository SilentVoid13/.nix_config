{ ... }:
{
  flake.modules.homeManager.ghidra =
    { pkgs, config, ... }:
    let
      ghidra_dir = ".config/ghidra/${pkgs.ghidra.distroPrefix}";
    in
    {
      home.packages = with pkgs; [
        ghidra
      ];

      # little trick to keep a read-write file
      home.file."${ghidra_dir}/preferences.bak" = {
        text = ''
          GhidraShowWhatsNew=false
          SHOW.HELP.NAVIGATION.AID=true
          SHOW_TIPS=false
          TIP_INDEX=0
          G_FILE_CHOOSER.ShowDotFiles=true
          USER_AGREEMENT=ACCEPT
          LastExtensionImportDirectory=${config.home.homeDirectory}/.config/ghidra/scripts/
          LastNewProjectDirectory=${config.home.homeDirectory}/.config/ghidra/projects/
          ViewedProjects=
          RecentProjects=
        '';
        target = "${ghidra_dir}/preferences.bak";
        onChange = ''
          config_source="$HOME/${ghidra_dir}/preferences.bak"
          config="$HOME/${ghidra_dir}/preferences"
          if [ ! -e "$config" ]; then
            cp "$config_source" "$config"
            chmod 640 "$config"
          fi
        '';
      };

      # little trick to keep a read-write file
      home.file."${ghidra_dir}/tools/_code_browser.tcd.bak" = {
        source = ./_config/_code_browser.tcd;
        target = "${ghidra_dir}/tools/_code_browser.tcd.bak";
        onChange = ''
          config_source="$HOME/${ghidra_dir}/tools/_code_browser.tcd.bak"
          config="$HOME/${ghidra_dir}/tools/_code_browser.tcd"
          if [ ! -e "$config" ]; then
            cp "$config_source" "$config"
            chmod 640 "$config"
          fi
        '';
      };
    };
}
