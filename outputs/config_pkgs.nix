{
  pkgs-stable,
  nurpkgs ? null,
  nixgl ? null,
  ...
}:
{
  nixpkgs = {
    config.allowUnfree = true;
    overlays =
      [
        # FIXME: broken, doesn't compile
        (self: super: {
          lldb = pkgs-stable.lldb;
        })
      ]
      ++ (if nurpkgs != null then [ nurpkgs.overlays.default ] else [ ])
      ++ (if nixgl != null then [ nixgl.overlay ] else [ ]);
  };
}
