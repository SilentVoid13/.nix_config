{
  config,
  myconf,
  ...
}: let
  gitignore_global = "git/gitignore_global";
  gitconfig_work = "git/gitconfig_work";
in {
  xdg = {
    enable = true;
    configFile."${gitignore_global}".source = ./gitignore_global;
    configFile."${gitconfig_work}".text = ''
      [user]
          name = ${myconf.git.work.name}
          email = ${myconf.git.work.email}
          signingKey = "${myconf.git.work.key}"
    '';
  };

  programs.git = {
    enable = true;
    userName = myconf.git.personal.name;
    userEmail = myconf.git.personal.email;
    delta = {
      enable = true;
    };
    lfs = {
      enable = true;
    };
    signing = {
      key = myconf.git.personal.key;
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

    includes = [
      {
        path = "${config.xdg.configHome}/${gitconfig_work}";
        condition = "hasconfig:remote.*.url:git@${myconf.git.work.host}:*/**";
      }
    ];
  };
}
