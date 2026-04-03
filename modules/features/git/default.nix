{ self, ... }:
{
  flake.modules.homeManager.git =
    {
      config,
      ...
    }:
    let
      gitignore_global = "git/gitignore_global";
      gitconfig_work = "git/gitconfig_work";
    in
    {
      xdg = {
        enable = true;
        configFile."${gitignore_global}".source = ./_files/gitignore_global;
        configFile."${gitconfig_work}".text = ''
          [user]
              name = ${self.myconf.git.work.name}
              email = ${self.myconf.git.work.email}
              signingKey = "${self.myconf.git.work.key}"
        '';
      };

      programs.git = {
        enable = true;

        settings = {
          user.name = self.myconf.git.personal.name;
          user.email = self.myconf.git.personal.email;

          gpg.format = "ssh";
          gpg.ssh.program = "op-ssh-sign";

          # global gitignore with common patterns
          core.excludesFile = "${config.xdg.configHome}/${gitignore_global}";

          # sort branches by last commit date descending
          branch.sort = "-committerdate";

          # auto setup remote branch
          push.autosetupremote = "true";

          # rebase when pulling
          pull.rebase = "true";
        };
        lfs = {
          enable = true;
        };
        signing = {
          key = self.myconf.git.personal.key;
          signByDefault = true;
          format = null;
        };

        includes = [
          {
            path = "${config.xdg.configHome}/${gitconfig_work}";
            condition = "hasconfig:remote.*.url:git@${self.myconf.git.work.host}:*/**";
          }
          {
            path = "${config.xdg.configHome}/${gitconfig_work}";
            condition = "hasconfig:remote.*.url:ssh://git@${self.myconf.git.work.host}:*/**";
          }
        ];
      };

      programs.delta = {
        enable = true;
        enableGitIntegration = true;
      };
    };
}
