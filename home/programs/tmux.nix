{
  config,
  pkgs,
  ...
}: let
in {
    programs.tmux = {
        enable = true;

        keyMode = "vi";
        prefix = "C-a";
        baseIndex = 1;
        escapeTime = 0;
        terminal = "screen-256color";
        shell = "${pkgs.zsh}/bin/zsh";
        historyLimit = 5000;

        # maybe
        # set-window-option -g xterm-keys on

        extraConfig = ''
            bind -r ^ last-window
            bind -r k select-pane -U
            bind -r j select-pane -D
            bind -r h select-pane -L
            bind -r l select-pane -R

            bind -T copy-mode-vi v send -X begin-selection
            bind -T copy-mode-vi y send -X copy-selection-and-cancel
            bind -T copy-mode-vi Escape send -X cancel

            bind -n C-k clear-history

            bind '"' split-window -c "#{pane_current_path}"
            bind % split-window -h -c "#{pane_current_path}"
            bind c new-window -c "#{pane_current_path}"
    
            set -g status-style 'bg=#333333 fg=#5eacd3'

            set -g renumber-windows on
        '';
    };
}
