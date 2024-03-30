{...}: {
  programs.wofi = {
    enable = true;
    settings = {
      gtk_dark = true;
      insensitive = true;
    };
  };
}
