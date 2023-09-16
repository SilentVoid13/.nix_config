{
  inputs,
  system,
  pkgs,
  myconf,
  ...
}: let
in {
  networking = {
    hostName = "jet";
    wireless.enable = true;
    useDHCP = true;
  };

  security = {
    polkit.enable = true;
  };

  programs = {
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["${myconf.username}"];
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
