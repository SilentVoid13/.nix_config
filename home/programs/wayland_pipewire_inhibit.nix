{ inputs, ... }:
{
  imports = [
    inputs.wayland-pipewire-idle-inhibit.homeModules.default
  ];

  services.wayland-pipewire-idle-inhibit = {
    enable = true;
    systemdTarget = "sway-session.target";
    settings = {
      verbosity = "WARN";
      media_minimum_duration = 5;
      idle_inhibitor = "wayland";
      sink_whitelist = [ ];
      node_blacklist = [
        { name = "spotify"; }
      ];
    };
  };
}
