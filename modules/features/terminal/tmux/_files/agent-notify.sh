#!/usr/bin/env bash
set -euo pipefail
pane=$1 title=$2 body=$3

# -A implies --wait; the chosen action name goes to stdout.
# "default" is the click-the-body action; swaync honours it.
action=$(notify-send -a opencode -u critical -t 0 \
    -A default=Jump -A dismiss=Dismiss \
    "$title" "$body") || exit 0
[[ $action == default ]] || exit 0

# pane may be gone by the time you click
info=$(tmux display-message -p -t "$pane" '#{session_name} #{window_id}') || exit 0
read -r sess win <<<"$info"

# pick an ordinary client, preferring one already on that session
tty=""
while read -r ctl csess ctty; do
    [[ $ctl == 0 ]] || continue # skip control-mode clients
    [[ -z $tty ]] && tty=$ctty
    [[ $csess == "$sess" ]] && {
        tty=$ctty
        break
    }
done < <(tmux list-clients -F '#{client_control_mode} #{client_session} #{client_tty}')
[[ -n $tty ]] || exit 0

tmux switch-client -c "$tty" -t "$sess"
tmux select-window -t "$win"
tmux select-pane -t "$pane"

# --- niri ---
cpid=$(ps -o pid=,comm= -t "${tty#/dev/}" | awk '$2 ~ /tmux/ {print $1; exit}') || true
fpid=$(ps -o ppid= -p "${cpid:-0}" 2>/dev/null | tr -d ' ') || true
wins=$(niri msg --json windows)

# 1. a single window owned by that pid (plain `foot`, one process per window)
id=$(jq -r --argjson p "${fpid:-0}" \
    '[.[] | select(.pid == $p)] | if length == 1 then .[0].id else empty end' <<<"$wins")

# 2. `foot --server` shares one pid across all windows, so fall back to the title
if [[ -z $id ]]; then
    id=$(jq -r --arg s "$sess" \
        'first(.[] | select(.title | startswith($s + ":")) | .id) // empty' <<<"$wins")
fi

# 3. last resort
if [[ -z $id ]]; then
    id=$(jq -r 'first(.[] | select(.app_id == "foot") | .id) // empty' <<<"$wins")
fi

if [[ -n $id ]]; then
    niri msg action focus-window --id "$id"
fi
