{
  description = "Nix system configuration";

  inputs = {
    #nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?ref=9a9dae8f6319600fa9aebde37f340975cab4b8c0";

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

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nurpkgs,
    home-manager,
    nixgl,
    nixvim,
    lanzaboote,
  } : let
    myconf = import ./utils/myconf.nix {};
  in {
    homeConfigurations = import ./outputs/home.nix {
      inherit nixpkgs;
      inherit myconf;
      inherit nurpkgs;
      inherit home-manager;
      inherit nixgl;
      inherit nixvim;
    };

    nixosConfigurations = import ./outputs/nixos.nix {
      inherit nixpkgs;
      inherit myconf;
      inherit lanzaboote;
    };
  };
}
