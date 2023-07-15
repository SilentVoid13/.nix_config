{
  config,
  pkgs,
  ...
}: let
  # TODO: improve that
  home = config.home.homeDirectory;
  sockPath = "${home}/.1password/agent.sock";
in {
  home.packages = with pkgs; [
    _1password-gui
  ];

  programs.ssh = {
    enable = true;
    extraConfig = ''
      IdentityAgent "${sockPath}"
    '';
  };
}
