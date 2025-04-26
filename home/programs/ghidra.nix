{
  pkgs,
  config,
  ...
}:
let
  ghidra_dir = ".config/ghidra/${pkgs.ghidra.distroPrefix}";

  #catppuccin = pkgs.fetchFromGitHub {
  #  owner = "catppuccin";
  #  repo = "ghidra";
  #  rev = "bed0999f96ee9869ed25e0f1439bef5eff341e22";
  #  hash = "sha256-mm7oxP8Fpn8PuyIgcsm6ZIfq11aEqqpzDL3FAF58ods=";
  #};
  #themeName = "catppuccin-macchiato";

  gruvbox = pkgs.fetchFromGitHub {
    owner = "kStor2poche";
    repo = "ghidra-gruvbox-theme";
    rev = "d6dc573532e6a4ac4c294cc80c9217fcfa90348f";
    hash = "sha256-2OzWZBKDdWcJ6CJ8Q5PbtqUHtpdHVtIDdtwaiuB/LLo=";
  };
in
{
  home.packages = with pkgs; [
    ghidra
  ];

  home.file."${ghidra_dir}/preferences".text = ''
    GhidraShowWhatsNew=false
    SHOW.HELP.NAVIGATION.AID=true
    SHOW_TIPS=false
    TIP_INDEX=0
    G_FILE_CHOOSER.ShowDotFiles=true
    USER_AGREEMENT=ACCEPT
    LastExtensionImportDirectory=${config.home.homeDirectory}/.config/ghidra/scripts/
    LastNewProjectDirectory=${config.home.homeDirectory}/.config/ghidra/repos/
    Theme=File\:${gruvbox}/gruvbox-dark-hard.theme
    ViewedProjects=
    RecentProjects=
  '';
  #Theme=File\:${catppuccin}/themes/${themeName}.theme

  #systemd.user.tmpfiles.rules = [
  #  # https://www.man7.org/linux/man-pages/man5/tmpfiles.d.5.html
  #  "d %h/${ghidra_dir} 0700 - - -"
  #  "L+ %h/.config/ghidra/latest - - - - %h/${ghidra_dir}"
  #  "d %h/.config/ghidra/scripts 0700 - - -"
  #  "d %h/.config/ghidra/repos 0700 - - -"
  #];
}
