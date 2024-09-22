# This substitutes tmux with a relatively new master that has
# https://github.com/tmux/tmux/issues/4017 fixed
final: prev: {
  tmux = prev.tmux.overrideAttrs (old: {
    patches = [];
    src = prev.fetchFromGitHub {
      owner = "tmux";
      repo = "tmux";
      rev = "34807388b064ed922293f128324b7d5d96f0c84d"; # master @ 27.08.2024
      hash = "sha256-zG3oRaahQCOVGTWfWwhDff5/iNbbWbxwIX/clK3vEPM=";
    };
  });
}
