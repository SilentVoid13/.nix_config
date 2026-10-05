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
        settings = {
          allowed-users = [ "${self.myconf.username}" ];
          extra-substituters = [ "https://cache.numtide.com" ];
          extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
        };
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
