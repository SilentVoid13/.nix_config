{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    (import ./mypkg.nix {inherit pkgs;})
  ];

  home.file.".binaryninja/keybindings.json" = {
    source = ./keybindings.json;
  };

  home.file.".binaryninja/settings.json" = {
    source = ./settings.json;
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
