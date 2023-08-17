{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    clang
    rustup
    lua
  ];

  xdg = {
    enable = true;
    configFile."rustfmt/rustfmt.toml".text = ''
        edition = "2021"
    '';
  };

  # TODO: install cargo-expand?
}
