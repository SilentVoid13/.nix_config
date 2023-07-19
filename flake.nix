{
  description = "Nix system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nurpkgs.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    pkgs = import nixpkgs {
      config.allowUnfree = true;
    };
  in {
    homeConfigurations.laptop = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        nur = inputs.nurpkgs;
        inherit inputs;
      };

      modules = [
        {
          home.username = "sv";
          home.homeDirectory = "/home/sv";
          home.stateVersion = "23.05";
          home.packages = [pkgs.home-manager];
        }
        ./home/main.nix
      ];
    };
  };
}
