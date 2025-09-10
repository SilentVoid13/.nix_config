{ pkgs, config, ... }:
{
  programs.htop = {
    enable = true;
    package = pkgs.htop-vim;
    settings = {
      # tree_view = true;
      show_cpu_frequency = true;
      show_cpu_temperature = true;
      highlight_base_name = true;
      show_program_path = false;
      hide_userland_threads = true;

      fields = with config.lib.htop.fields; [
        PID
        USER
        M_RESIDENT
        PERCENT_CPU
        COMM
      ];
    }
    // (
      with config.lib.htop;
      leftMeters [
        (bar "AllCPUs")
        (graph "CPU")
      ]
    )
    // (
      with config.lib.htop;
      rightMeters [
        (bar "Memory")
        (bar "Swap")
        (text "Zram")
        (text "Tasks")
        (text "LoadAverage")
        (text "Uptime")
        (text "Systemd")
        (text "Battery")
        (graph "GPU")
      ]
    );
  };
}
