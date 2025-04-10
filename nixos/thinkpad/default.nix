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

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
  ];
}
