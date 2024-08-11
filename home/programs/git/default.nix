{
  config,
  myconf,
  ...
}: let
  gitignore_global = "git/gitignore_global";
in {
  # TODO: add dependency over 1password.nix?

  xdg = {
    enable = true;
    configFile."${gitignore_global}".source = ./gitignore_global;
  };

  programs.git = {
    enable = true;
    userName = myconf.git_user;
    userEmail = myconf.git_email;
    delta = {
      enable = true;
    };
    lfs = {
      enable = true;
    };
    signing = {
      key = myconf.ssh_key;
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
