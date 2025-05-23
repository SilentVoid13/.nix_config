{
  pkgs,
  config,
  myconf,
  ...
}:
let
  omz_dir = "zsh/oh-my-zsh/";
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
    GEM_HOME = "$HOME/.gem/";
    GO111MODULE = "on";
    NPM_PACKAGES = "$HOME/npm_packages";
    NODE_PATH = "$NODE_PATH:$NPM_PACKAGES/lib/node_modules";
    MANPATH = "$MANPATH:$NPM_PACKAGES/share/man";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
    "$HOME/npm_packages/bin"
  ];

  xdg = {
    enable = true;
    configFile."${omz_dir}/themes/mytheme.zsh-theme".source = ./mytheme.zsh-theme;
  };

  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";
    autocd = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "z"
        "tmux"
        "git"
      ];
      custom = "${config.xdg.configHome}/${omz_dir}";
      theme = "mytheme";
    };
    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

    dirHashes = {
      h = "$HOME/H";
      dot = "$HOME/.nix_config";
      k = "${myconf.knowledge_base}";
    };

    history = {
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      size = 10000;
    };

    shellAliases = {
      ll = "eza -lah --icons --color=always --group-directories-first";
      ls = "ll";
      "l." = "eza -a --group-directories-first | rg '^\.'";
      rt = "trash put";
      cat = "bat --paging=never -p";
      #grep = "rg";
      rgi = "rg -i -. --no-ignore";
      cp = "cp -i";
      mv = "mv -i";
      cpp = "rsync -aP";
      mvp = "rsync -aP --remove-source-files";
      clip = "wl-copy";
      zettel = "date +%Y%m%d%H%M";
      crr = "cargo run --release";
      sshp = "ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no ";
      gll = "git stash && git pull && git stash pop";
    };

    initContent = ''
      env_shell() {
        cp ${./base_shell.nix} shell.nix
        chmod 644 shell.nix
        echo 'use nix' > .envrc
        direnv allow
      }
      env_fhs() {
        cp ${./base_fhs.nix} shell.nix
        chmod 644 shell.nix
        echo 'use nix' > .envrc
        direnv allow
      }
      env_flake() {
        cp ${./base_flake.nix} flake.nix
        chmod 644 flake.nix
        echo 'use flake' > .envrc
        direnv allow
      }
      env_rust() {
        # kind of ugly but it's for naersk to be happy
        nix-shell -p cargo --run "cargo init && cargo generate-lockfile"
        git add Cargo.toml Cargo.lock 

        cp ${./base_rust.nix} flake.nix
        chmod 644 flake.nix
        git add flake.nix
        echo 'use flake' > .envrc
        direnv allow
      }
    '';

    # TODO: move to /usr/bin/sway thing on non-nixos
    profileExtra =
      # bash
      ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
            exec sway --unsupported-gpu
            #exec Hyprland
        fi
      '';
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
