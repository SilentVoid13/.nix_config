{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # This causes compilation problem for apps looking for /usr/lib/libclang*
    # on non-nixos systems
    #clang

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
