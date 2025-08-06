{
  nixpkgs,
  nixpkgs-stable,
  myconf,
  nurpkgs,
  home-manager,
  nixgl,
  inputs,
  ...
}:
let
  mkHomeConfig =
    {
      system,
      username,
      isNixOs,
      modules,
    }:
    let
      pkgs-stable = import nixpkgs-stable { inherit system; };
      pkgs = import nixpkgs { inherit system; };

      nixGLWrap =
        pkg:
        if !isNixOs then
          pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
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
        else
          pkg;
    in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit nixGLWrap;
        inherit myconf;
        inherit inputs;
        inherit pkgs-stable;
      };
      modules = [
        (import ./config_pkgs.nix {
          inherit pkgs-stable;
          inherit nurpkgs;
          inherit nixgl;
        })
        (if builtins.pathExists ../extra/home.nix then import ../extra/home.nix else { })
        {
          home.username = "${username}";
          home.homeDirectory = "/home/${username}";
          home.stateVersion = "23.05";
          home.packages = [
            pkgs.home-manager
          ]
          ++ (if !isNixOs then [ pkgs.nixgl.auto.nixGLDefault ] else [ ]);
        }
      ]
      ++ modules;
    };
in
{
  full_non_nixos = mkHomeConfig {
    system = "x86_64-linux";
    username = "${myconf.username}";
    isNixOs = false;
    modules = [ ../home/full.nix ];
  };

  full = mkHomeConfig {
    system = "x86_64-linux";
    username = "${myconf.username}";
    isNixOs = true;
    modules = [ ../home/full.nix ];
  };

  work = mkHomeConfig {
    system = "x86_64-linux";
    username = "${myconf.username}";
    isNixOs = true;
    modules = [ ../home/work.nix ];
  };
}
