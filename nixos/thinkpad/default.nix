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
  services.auto-cpufreq.enable = true;

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
  ];
}
