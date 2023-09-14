{
  config,
  pkgs,
  ...
}: let
in {
  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";
    autocd = true;
    enableAutosuggestions = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "z" "tmux" "git"];
      theme = "robbyrussell";
    };

    dirHashes = {
      h = "$HOME/H";
      dot = "$HOME/.dotfiles_nix";
      r = "$HOME/.resources";
    };

    history = {
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      size = 10000;
    };

    shellAliases = {
      ll = "exa -lah --icons --color=always --group-directories-first";
      ls = "ll";
      "l." = "exa -a --group-directories-first | rg '^\.'";
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

    initExtra = ''
        export PYENV_ROOT="$HOME/.pyenv"
        command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
    '';

    envExtra = ''
      # Preferred editor for local and remote sessions
      export EDITOR='nvim'

      # Sets bat as manpager
      export MANPAGER="sh -c 'col -bx | bat -l man -p'"
      export MANPATH="/usr/local/man:$MANPATH"

      # Sourcing cargo env
      . "$HOME/.cargo/env"

      # GEM binaries
      export GEM_HOME=$HOME/.gem/

      # local user binaries
      export PATH=$PATH:$HOME/.local/bin

      # Go binaries
      export PATH=$PATH:$HOME/go/bin
      export GO111MODULE=on

      # npm binaries
      export NPM_PACKAGES=$HOME/npm_packages
      export NODE_PATH=$NODE_PATH:$NPM_PACKAGES/lib/node_modules
      export PATH=$PATH:$NPM_PACKAGES/bin
      export MANPATH="$MANPATH:$NPM_PACKAGES/share/man"
    '';

    profileExtra = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
          export XDG_CURRENT_DESKTOP="sway"
          export MOZ_ENABLE_WAYLAND=1
          export _JAVA_AWT_WM_NONREPARENTING=1
          export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS
          export NIXOS_OZONE_WL=1
          export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

          exec /usr/bin/sway --unsupported-gpu
      fi
    '';
  };
}
