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
      fenix,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ fenix.overlays.default ];
          config.allowUnfree = true;
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

        buildPkg =
          arch_pkgs:
          with arch_pkgs;
          (makeRustPlatform {
            cargo = toolchain;
            rustc = toolchain;
          }).buildRustPackage
            {
              pname = "<name>";
              version = "0.0.1";
              src = ./.;
              cargoLock.lockFile = ./Cargo.lock;
              strictDeps = true;
              nativeBuildInputs = [ pkgs.pkg-config ];
              buildInputs = fnBuildInputs arch_pkgs;
            };

        fnBuildInputs = pkgs: with pkgs; [ ];
      in
      rec {
        defaultPackage = buildPkg pkgs;
        # packages.x86_64-unknown-linux-musl = buildPkg pkgs.pkgsCross.musl64.pkgsStatic;
        # packages.aarch64-linux-android = buildPkg pkgs.pkgsCross.aarch64-android-prebuilt;
        # packages.aarch64-multiplatform-musl = buildPkg pkgs.pkgsCross.aarch64-multiplatform-musl.pkgsStatic;
        # packages.x86_64-pc-windows-gnu = buildPkg pkgs.pkgsCross.mingwW64;

        devShell = pkgs.mkShell {
          inputsFrom = [ defaultPackage ];
          # packages = shellPkgs;
          #LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath (fnBuildInputs pkgs)}";
        };
      }
    );
}
