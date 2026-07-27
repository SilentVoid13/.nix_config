#!/usr/bin/env bash
set -euo pipefail

jadx_version=$(curl -sSf \
    ${GITHUB_TOKEN:+-H "Authorization: Bearer $GITHUB_TOKEN"} \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/skylot/jadx/actions/artifacts?per_page=100" |
    jq -r '[ .artifacts[]
             | select(.expired == false)
             | select(.workflow_run.head_branch == "master")
             | select(.name | test("^jadx-r[0-9]+\\.[0-9a-f]+")) ]
           | sort_by(.created_at) | last | .name
           | ltrimstr("jadx-")')

[ -n "$jadx_version" ] && [ "$jadx_version" != "null" ] || {
    echo "no master artifact found" >&2
    exit 1
}

current=$(nix eval --raw .#custom_jadx.version)
if [ "$jadx_version" = "$current" ]; then
    echo "already at $jadx_version"
    exit 0
fi

nix run github:Mic92/nix-update -- --flake custom_jadx --version="$jadx_version"
