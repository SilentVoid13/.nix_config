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

    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = {self, ...} @ inputs: let
  in {
    homeConfigurations = import ./outputs/home.nix {
      inherit inputs;
    };
  };
}
