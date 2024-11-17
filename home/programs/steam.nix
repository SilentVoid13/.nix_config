{pkgs, ...}: {
  home.packages = with pkgs; [
    # NOTE: steam can require some system-level permissions
    #steam
    # NOTE: GameMode depends on root-level capabilities that aren't available in a user-level Nix package installation
    #gamemode

    steam-run
    gamescope
    # for proton-ge
    protonup
  ];

  programs.mangohud.enable = true;

  # use nvidia offload-mode
  xdg.desktopEntries = {
    "steam" = {
      name = "Steam Nvidia";
      exec = "nvidia-offload steam %U";
      icon = "steam";
      mimeType = ["x-scheme-handler/steam" "x-scheme-handler/steamlink"];
      type = "Application";
      terminal = false;
    };
  };
}
