{...}: {
  xdg = {
    enable = true;
    configFile."rustfmt/rustfmt.toml".text = ''
      edition = "2024"
    '';
  };
}
