{
  config,
  pkgs,
  ...
}: let
  home = config.home.homeDirectory;
  gitignore_global = "git/gitignore_global";
in {
  home.packages = with pkgs; [
    _1password-gui
  ];

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
      gpg.ssh.program = "${pkgs._1password-gui}/bin/op-ssh-sign";
      core.excludefiles = "${config.xdg.configHome}/${gitignore_global}";
    };
  };
}
