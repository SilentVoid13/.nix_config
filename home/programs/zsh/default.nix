{
  config,
  pkgs,
  ...
}: let
  omz_dir = "zsh/oh-my-zsh/";
in {
  home.sessionVariables = {
    EDITOR = "nvim";
    GEM_HOME = "$HOME/.gem/";
    GO111MODULE = "on";
    NPM_PACKAGES = "$HOME/npm_packages";
    NODE_PATH = "$NODE_PATH:$NPM_PACKAGES/lib/node_modules";
    MANPATH = "$MANPATH:$NPM_PACKAGES/share/man";
  };

  home.sessionPath = ["$HOME/.local/bin" "$HOME/go/bin" "$HOME/npm_packages/bin"];

  xdg = {
    enable = true;
    configFile."${omz_dir}/themes/mytheme.zsh-theme".source = ./mytheme.zsh-theme;
  };

  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";
    autocd = true;
    enableAutosuggestions = true;

    oh-my-zsh = {
      enable = true;
      plugins = ["z" "tmux" "git"];
      custom = "${config.xdg.configHome}/${omz_dir}";
      theme = "mytheme";
    };

    dirHashes = {
      h = "$HOME/H";
      dot = "$HOME/.nix_config";
      r = "$HOME/.resources";
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
      grep = "rg";
      rgi = "rg -i -. --no-ignore";
      cp = "cp -i";
      mv = "mv -i";
      cpp = "rsync -aP";
      mvp = "rsync -aP --remove-source-files";
      clip = "wl-copy";
      zettel = "date +%Y%m%d%H%M";
      crr = "cargo run --release";
    };

    # todo: move to /usr/bin/sway thing on non-nixos
    profileExtra = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
          export XDG_CURRENT_DESKTOP="sway"
          export MOZ_ENABLE_WAYLAND=1
          export _JAVA_AWT_WM_NONREPARENTING=1
          export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS
          export NIXOS_OZONE_WL=1
          export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

          exec sway --unsupported-gpu
      fi
    '';
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
}
