{pkgs, ...}: {
  home.packages = with pkgs; [
    #super-productivity
    (pkgs.callPackage ./superprod_pkg.nix {})
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
