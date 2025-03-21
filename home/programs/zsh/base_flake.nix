{
  description = "<desc>";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }: let
  in
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        buildInputs = with pkgs; [];
        nativeBuildInputs = with pkgs; [];
      in {
        devShell = pkgs.mkShell {
          inherit buildInputs;
          inherit nativeBuildInputs;
        };
      }
    );
}

