{
  description = "<name>";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      fenix,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ fenix.overlays.default ];
        };

        toolchain =
          with fenix.packages.${system};
          combine [
            # default / complete / latest / minimal = nightly
            # stable
            # beta

            default.rustc
            default.cargo
            default.clippy
            default.rustfmt
            pkgs.rust-analyzer
            # complete.rustc-codegen-cranelift-preview

            # targets.x86_64-unknown-linux-musl.latest.rust-std
            # targets.aarch64-unknown-linux-musl.latest.rust-std
            # targets.x86_64-pc-windows-gnu.latest.rust-std
            # targets.aarch64-linux-android.latest.rust-std
          ];

        buildInputs = with pkgs; [
          toolchain
        ];
        nativeBuildInputs = with pkgs; [ ];
      in
      {
        devShell = pkgs.mkShell {
          inherit buildInputs nativeBuildInputs;
          #LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath buildInputs}";
        };
      }
    );
}
