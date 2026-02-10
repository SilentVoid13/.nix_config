{
  pkgs-stable,
  nurpkgs ? null,
  nixgl ? null,
  niri ? null,
  ...
}:
{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      # FIXME: broken, doesn't compile
      (self: super: {
        lldb = pkgs-stable.lldb;
      })
    ]
    ++ (if nurpkgs != null then [ nurpkgs.overlays.default ] else [ ])
    ++ (if niri != null then [ niri.overlays.niri ] else [ ])
    ++ (if nixgl != null then [ nixgl.overlay ] else [ ]);
  };
}
