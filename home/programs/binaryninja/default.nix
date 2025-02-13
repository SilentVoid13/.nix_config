{
  pkgs,
  config,
  ...
}: let 
    base_settings = ".binaryninja/settings-base.json";
    settings = ".binaryninja/settings.json";
    base_keybindings = ".binaryninja/keybindings-base.json";
    keybindings = ".binaryninja/keybindings.json";
in {
  home.packages = [
    (import ../../../pkgs/binja.nix {inherit pkgs;})
  ];

  # HACK: allows modification of the files to avoid RO
  home.file."${settings}" = {
    source = ./settings.json;
    target = "${base_settings}";
    onChange = ''cp ${base_settings} ${settings} && chmod 644 ${settings}'';
  };
  home.file."${keybindings}" = {
    source = ./keybindings.json;
    target = "${base_keybindings}";
    onChange = ''cp ${base_keybindings} ${keybindings} && chmod 644 ${keybindings}'';
  };

  xdg.desktopEntries = {
    "binaryninja" = {
      name = "Binary Ninja";
      exec = "env QT_QPA_PLATFORM=wayland binaryninja -platform wayland %u";
      icon = "${config.home.homeDirectory}/binaryninja/docs/img/logo.png";
      mimeType = ["application/x-binaryninja" "x-scheme-handler/binaryninja"];
      categories = ["Utility"];
      type = "Application";
      terminal = false;
    };
  };
}
