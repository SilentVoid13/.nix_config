{ config, myconf, ... }:
let
  # TODO: improve that
  home = config.home.homeDirectory;
  sockPath = "${home}/.1password/agent.sock";
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [ "${home}/.ssh/1Password/config" ];
    matchBlocks = {
      "${myconf.git.work.host}" = {
        user = "git";
        port = 2222;
      };
      "homelab" = {
        forwardAgent = true;
      };
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        identityAgent = "${sockPath}";
      };
    };
  };

  # https://github.com/nix-community/home-manager/issues/322
  # FIXME: workaround
  home.file.".ssh/config" = {
    target = ".ssh/config_source";
    onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config'';
  };
}
