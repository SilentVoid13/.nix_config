{
  config,
  pkgs,
  ...
}: let
  home = config.home.homeDirectory;
  gitignore_global = "git/gitignore_global";
in {
  # TODO: add dependency over 1password.nix?

  xdg = {
    enable = true;
    configFile."${gitignore_global}".source = ./gitignore_global;
  };

  programs.git = {
    enable = true;
    userName = "SilentVoid13";
    userEmail = "51264226+SilentVoid13@users.noreply.github.com";
    delta = {
      enable = true;
    };
    lfs = {
      enable = true;
    };
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4upjUw/TdQOTnUSdhH6DAfdLyJE1VRd/ZvV4eBqjIY";
      signByDefault = true;
    };
    extraConfig = {
      gpg.format = "ssh";
      gpg.ssh.program = "op-ssh-sign";

      # global gitignore with common patterns
      core.excludefiles = "${config.xdg.configHome}/${gitignore_global}";

      # sort branches by last commit date descending
      branch.sort = "-committerdate";

      # auto setup remote branch
      push.autosetupremote = "true";

      # rebase when pulling
      pull.rebase = "true";
    };
  };
}
