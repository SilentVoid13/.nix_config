{myconf, ...}: {
  services.syncthing = {
    enable = true;
    settings = {
      folders = {
        "knowledge_base" = {
          path = myconf.knowledge_base;
        };
      };
    };
  };
}
