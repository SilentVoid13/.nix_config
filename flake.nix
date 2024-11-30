{
  description = "Nix system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";
    nixpkgs-staging.url = "nixpkgs/staging-next";

    nurpkgs = {
      url = "github:nix-community/NUR";
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
      url = "github:nix-community/lanzaboote/v0.4.1";
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
  };

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    nurpkgs,
    home-manager,
    nixgl,
    nixvim,
    arkenfox,
    lanzaboote,
    disko,
    stylix,
    wayland-pipewire-idle-inhibit,
    ...
  }: let
    myconf = import ./utils/myconf.nix {};
  in {
    homeConfigurations = import ./outputs/home.nix {
      inherit nixpkgs;
      inherit nixpkgs-stable;
      inherit myconf;
      inherit nurpkgs;
      inherit home-manager;
      inherit nixgl;
      inherit nixvim;
      inherit arkenfox;
      inherit stylix;
      inherit wayland-pipewire-idle-inhibit;
    };

    nixosConfigurations = import ./outputs/nixos.nix {
      inherit nixpkgs;
      inherit myconf;
      inherit lanzaboote;
      inherit disko;
    };
  };
}
