{ inputs, self, ... }:
{
  flake.modules.nixos.nix-settings =
    {
      pkgs,
      ...
    }:
    {
      nix = {
        package = pkgs.nixVersions.latest;
        settings.allowed-users = [ "${self.myconf.username}" ];
        extraOptions = ''
          experimental-features = nix-command flakes
        '';
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 15d";
        };
        # use existing nixpkgs for commands like nix-shell
        registry.nixpkgs.flake = inputs.nixpkgs;
      };
    };
}
