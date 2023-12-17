{pkgs, ...}: {
  home.packages = with pkgs; [
    darkman
  ];

  xdg = {
    dataFile."dark-mode.d/gtk-theme.sh" = {
      executable = true;
      text = ''
        export XDG_DATA_DIRS="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}":$XDG_DATA_DIRS
        gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      '';
    };
    dataFile."dark-mode.d/desktop-notif.sh" = {
      executable = true;
      text = ''notify-send --app-name="darkman" --urgency=low --icon=weather-clear-night "switching to dark mode"'';
    };
    dataFile."light-mode.d/gtk-theme.sh" = {
      executable = true;
      text = ''
        export XDG_DATA_DIRS="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}":$XDG_DATA_DIRS
        gsettings set org.gnome.desktop.interface gtk-theme Adwaita
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
      '';
    };
    dataFile."light-mode.d/desktop-notif.sh" = {
      executable = true;
      text = ''notify-send --app-name="darkman" --urgency=low --icon=weather-clear-night "switching to light mode"'';
    };
    configFile."darkman/config.yaml".text = ''
      lat: 48.8
      lng: 2.3
      usegeoclue: false
    '';
  };
}
