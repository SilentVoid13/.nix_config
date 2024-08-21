{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    steam-run
    gamescope
    gamemode
    # proton-ge
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
