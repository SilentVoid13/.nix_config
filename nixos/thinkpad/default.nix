{
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common_base.nix
  ];

  networking = {
    hostName = "faye";
  };

  zramSwap.enable = true;

  powerManagement.cpuFreqGovernor = "performance";
  #services.auto-cpufreq = {
  #  enable = true;
  #  settings = {
  #    battery = {
  #      governor = "powersave";
  #      turbo = "auto";
  #    };
  #    charger = {
  #      governor = "performance";
  #      turbo = "auto";
  #    };
  #  };
  #};

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
  ];
}
