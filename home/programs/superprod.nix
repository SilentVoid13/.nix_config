{pkgs, ...}: {
  home.packages = with pkgs; [
    super-productivity
  ];
  xdg.desktopEntries = {
    "super-productivity" = {
      name = "Super Productivity";
      exec = "super-productivity --ozone-platform=wayland --no-sandbox %U";
      icon = "superproductivity";
      categories = ["Utility"];
      type = "Application";
      terminal = false;
    };
  };
}
