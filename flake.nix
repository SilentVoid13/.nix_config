{
  description = "Nix system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";
    nixpkgs-staging.url = "nixpkgs/staging-next";

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

    arkenfox = {
      url = "github:dwarfmaster/arkenfox-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nurpkgs,
    home-manager,
    nixgl,
    nixvim,
    arkenfox,
    lanzaboote,
    ...
  }: let
    myconf = import ./utils/myconf.nix {};
  in {
    homeConfigurations = import ./outputs/home.nix {
      inherit nixpkgs;
      inherit myconf;
      inherit nurpkgs;
      inherit home-manager;
      inherit nixgl;
      inherit nixvim;
      inherit arkenfox;
    };

    nixosConfigurations = import ./outputs/nixos.nix {
      inherit nixpkgs;
      inherit myconf;
      inherit lanzaboote;
    };
  };
}
