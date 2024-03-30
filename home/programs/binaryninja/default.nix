{
  pkgs,
  ...
}: {
  home.packages = [
    ( import ./mypkg.nix { inherit pkgs; } )
  ];

  home.file.".binaryninja/keybindings.json" = {
    source = ./keybindings.json;
  };

  home.file.".binaryninja/settings.json" = {
    source = ./settings.json;
  };
}
