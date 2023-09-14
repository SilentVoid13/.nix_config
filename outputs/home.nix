{inputs, ...}:
with inputs; let
  pkgs = import nixpkgs {
    config.allowUnfree = true;
    overlays = [nixgl.overlay];
  };

  nixGLWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo "exec ${pkgs.lib.getExe pkgs.nixgl.nixGLIntel} $bin \"\$@\"" > $wrapped_bin
       chmod +x $wrapped_bin
      done
    '';
in {
  nonix_full = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {
      nur = inputs.nurpkgs;
      inherit inputs;
      nixGLWrap = nixGLWrap;
    };


    modules = [
      {
        home.username = "sv";
        home.homeDirectory = "/home/sv";
        home.stateVersion = "23.05";
        home.packages = [
          pkgs.home-manager
          pkgs.nixgl.auto.nixGLDefault
        ];
      }
      ../home/main.nix
    ];
  };
}
