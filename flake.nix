{
  description = "Nix system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";
    nixpkgs-staging.url = "nixpkgs/staging-next";

    nurpkgs = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    arkenfox = {
      url = "github:dwarfmaster/arkenfox-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wayland-pipewire-idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    otter-launcher = {
      url = "github:kuokuo123/otter-launcher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      nurpkgs,
      home-manager,
      nixgl,
      lanzaboote,
      disko,
      ...
    }@inputs:
    let
      myconf =
        if builtins.pathExists ./extra/conf.nix then
          (import ./extra/conf.nix { })
        else
          (import ./extra/conf.example.nix { });
    in
    {
      homeConfigurations = import ./outputs/home.nix {
        inherit nixpkgs;
        inherit nixpkgs-stable;
        inherit myconf;
        inherit nurpkgs;
        inherit home-manager;
        inherit nixgl;
        inherit inputs;
      };

      nixosConfigurations = import ./outputs/nixos.nix {
        inherit nixpkgs;
        inherit nixpkgs-stable;
        inherit myconf;
        inherit lanzaboote;
        inherit disko;
      };
    };
}
