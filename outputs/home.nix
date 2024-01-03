{
  inputs,
  myconf,
  ...
}: let
  mkHomeConfig = {
    system,
    username,
    isNixOs,
    modules,
  }: let
    pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        # TODO: Remove this
        permittedInsecurePackages = [
          "electron-25.9.0"
        ];
      };
      overlays =
        [inputs.nurpkgs.overlay]
        ++ (
          if !isNixOs
          then [inputs.nixgl.overlay]
          else []
        );
    };

    nixGLWrap = pkg:
      if !isNixOs
      then
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
        ''
      else pkg;
  in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs;
        inherit nixGLWrap;
        inherit myconf;
      };
      modules =
        [
          {
            home.username = "${username}";
            home.homeDirectory = "/home/${username}";
            home.stateVersion = "23.05";
            home.packages =
              [
                pkgs.home-manager
              ]
              ++ (
                if !isNixOs
                then [pkgs.nixgl.auto.nixGLDefault]
                else []
              );
          }
        ]
        ++ modules;
    };
in {
  non_nixos_full = mkHomeConfig {
    system = "x86_64-linux";
    username = "${myconf.username}";
    isNixOs = false;
    modules = [../home/full.nix];
  };

  nixos_full = mkHomeConfig {
    system = "x86_64-linux";
    username = "${myconf.username}";
    isNixOs = true;
    modules = [../home/full.nix];
  };
}
