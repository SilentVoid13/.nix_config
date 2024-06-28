{...}: {
  services.darkman = {
    enable = true;
    darkModeScripts = {
        gtk-theme = ''
            export XDG_DATA_DIRS="/nix/store/9l7yvc191515mj8fsvy3ngwf9mrrzv8h-gsettings-desktop-schemas-46.0/share/gsettings-schemas/gsettings-desktop-schemas-46.0":$XDG_DATA_DIRS
            gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
            gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        '';
        desktop-notif = ''
            notify-send --app-name="darkman" --urgency=low --icon=weather-clear-night "switching to dark mode"
        '';
    };
    lightModeScripts = {
        gtk-theme = ''
            export XDG_DATA_DIRS="/nix/store/9l7yvc191515mj8fsvy3ngwf9mrrzv8h-gsettings-desktop-schemas-46.0/share/gsettings-schemas/gsettings-desktop-schemas-46.0":$XDG_DATA_DIRS
            gsettings set org.gnome.desktop.interface gtk-theme Adwaita
            gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
        '';
        desktop-notif = ''
            notify-send --app-name="darkman" --urgency=low --icon=weather-clear-night "switching to light mode"
        '';
    };

    settings = {
      lat = 48.8;
      lng = 2.3;
      usegeoclue = false;
    };
  };
}
