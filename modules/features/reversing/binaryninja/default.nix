{ self, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      python = pkgs.python3.withPackages (
        p: with p; [
          pip
          torch
          pyperclip
          flatbuffers
          lief
        ]
      );
    in
    {
      packages.binja = pkgs.buildFHSEnv {
        name = "binaryninja";
        targetPkgs =
          pkgs: with pkgs; [
            dbus
            fontconfig
            freetype
            libGL
            libxkbcommon
            curl
            libx11
            libxcb
            libxcb-image
            libxcb-keysyms
            libxcb-render-util
            libxcb-wm
            wayland
            zlib
            libxml2
            # libxml2_13
            qt6.qtbase
            glib

            ## plugins stuff
            python
            astyle

            ## useful headers
            openssl.dev
            openssl_3
            linuxHeaders
            #linux_5_15.dev
            stdenv
            glibc.dev
          ];

        # NOTE: we enter a dedicated venv to pip install for plugins
        runScript = pkgs.writeShellScript "binaryninja.sh" ''
          set -e
          # allows pip install for plugins
          export PATH="${python}/bin:$PATH"
          export PYTHONPATH="${python}/lib/python3.13/site-packages:$PYTHONPATH"
          export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${
            pkgs.lib.makeLibraryPath [
              pkgs.openssl
              pkgs.openssl_3
            ]
          }"
          "$HOME/binaryninja/binaryninja" "$@"
        '';
        meta = {
          description = "BinaryNinja";
          platforms = [ "x86_64-linux" ];
        };
        multiArch = true;
      };
    };

  flake.modules.homeManager.binaryninja =
    { pkgs, config, ... }:
    let
      base_settings = ".binaryninja/settings-base.json";
      settings = ".binaryninja/settings.json";
      base_keybindings = ".binaryninja/keybindings-base.json";
      keybindings = ".binaryninja/keybindings.json";
    in
    {
      home.packages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.binja
      ];

      # HACK: allows modification of the files to avoid RO
      home.file."${settings}" = {
        source = ./_config/settings.json;
        target = "${base_settings}";
        onChange = "cp ${base_settings} ${settings} && chmod 644 ${settings}";
      };
      home.file."${keybindings}" = {
        source = ./_config/keybindings.json;
        target = "${base_keybindings}";
        onChange = "cp ${base_keybindings} ${keybindings} && chmod 644 ${keybindings}";
      };

      xdg.desktopEntries = {
        "binaryninja" = {
          name = "Binary Ninja";
          exec = "env QT_QPA_PLATFORM=wayland binaryninja -platform wayland %u";
          icon = "${config.home.homeDirectory}/binaryninja/docs/img/logo.png";
          mimeType = [
            "application/x-binaryninja"
            "x-scheme-handler/binaryninja"
          ];
          categories = [ "Utility" ];
          type = "Application";
          terminal = false;
        };
      };
    };
}
