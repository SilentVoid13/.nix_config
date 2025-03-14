{
  config,
  pkgs,
  ...
}: let
    tmux_sessionizer_rel = "tmux/tmux-sessionizer";
    tmux_sessionizer_abs = "${config.xdg.dataHome}/${tmux_sessionizer_rel}";
in {
  home.packages = with pkgs; [
    fzf
  ];

  xdg = {
    enable = true;
    dataFile."${tmux_sessionizer_rel}" = {
        source = ./tmux-sessionizer.sh;
        executable = true;
    };
  };

  programs.tmux = {
    enable = true;

    keyMode = "vi";
    prefix = "C-a";
    baseIndex = 1;
    escapeTime = 0;
    terminal = "screen-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    historyLimit = 5000;

    plugins = [
      pkgs.tmuxPlugins.extrakto
    ];

    # maybe
    # set-window-option -g xterm-keys on

    extraConfig = ''
      bind -r ^ last-window
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R
      bind -r K resize-pane -U 5
      bind -r J resize-pane -D 5
      bind -r L resize-pane -R 5
      bind -r H resize-pane -L 5

      bind-key -r f run-shell "tmux neww ${tmux_sessionizer_abs}"

      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
      bind -T copy-mode-vi Escape send -X cancel

      bind -n C-k clear-history

      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # quick style
      set -g status-style 'bg=#333333 fg=#5eacd3'

      # no gap between numbers when a window is closed
      set -g renumber-windows on

      # auto-switch to another active session after exiting
      set-option -g detach-on-destroy off
    '';
  };
}
