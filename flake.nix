{
  description = "Nix system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nurpkgs.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixgl,
    ...
  } @ inputs: let
    pkgs = import nixpkgs {
      config.allowUnfree = true;
      overlays = [ nixgl.overlay ];
    };
  in {
    homeConfigurations.laptop = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        nur = inputs.nurpkgs;
        inherit inputs;
        wrapGl = cmd: pkgs.writeShellScriptBin "${cmd}" ''nix
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
