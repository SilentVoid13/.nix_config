{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [];

  xdg = {
    enable = true;
    configFile."rustfmt/rustfmt.toml".text = ''
        edition = "2021"
    '';
  };
}
