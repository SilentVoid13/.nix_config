{isNixOs, ...}: let

in {
  mkConfig = {
    isNixOs,
    username,
    nixGLWrap,
    modules,
  }:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit nur;
        inherit inputs;
        inherit nixGLWrap;
      };
      modules =
        [
          {
            home.username = "${username}";
            home.homeDirectory = "/home/${username}";
            home.stateVersion = "23.05";
            home.packages = [
              pkgs.home-manager
              pkgs.nixgl.auto.nixGLDefault
            ];
          }
        ]
        ++ modules;
    };
}
