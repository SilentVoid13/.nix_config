{
  self,
  inputs,
  ...
}:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.username = "${self.myconf.username}";
      home.homeDirectory = "/home/${self.myconf.username}";
      home.stateVersion = "23.05";
      programs.home-manager.enable = true;

      imports = [
        (
          if builtins.pathExists ../extra/home.nix then
            import ../extra/home.nix {
              inherit pkgs;
              myconf = self.myconf;
            }
          else
            { }
        )
        self.modules.homeManager.common-terminal
        self.modules.homeManager.common-gui
      ];
    };
}
