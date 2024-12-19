{
  pkgs-stable,
  nurpkgs ? null,
  nixgl ? null,
  ...
}: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays =
      [
        # FIXME: remove tmp fix
        (self: super: {
          rust-analyzer = pkgs-stable.rust-analyzer;
        })

        # FIXME: broken "gen" keyword in rust
        (self: super: {
            vimPlugins = pkgs-stable.vimPlugins;
        })
      ]
      ++ (
        if nurpkgs != null
        then [nurpkgs.overlays.default]
        else []
      )
      ++ (
        if nixgl != null
        then [nixgl.overlay]
        else []
      );
  };
}