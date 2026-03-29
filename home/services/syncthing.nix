{ myconf, ... }:
{
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        "pixel9a" = {
          id = "WY5DIP5-SJOXPV7-7U4Q7FS-PVNTDUG-PYDFPVE-B4GLIZX-VUA73R4-5KINXQI";
          autoAcceptFolders = true;
        };
        "faye" = {
          id = "U5WYFHI-A7U57P4-ITTP6OD-43GXCIA-VTLU7TJ-RITZMOQ-ZXA7HLQ-HICBFAH";
          autoAcceptFolders = true;
        };
        "jet" = {
          id = "4HMBYZE-HSQ4SSF-ZVLPVHQ-YNUL2HS-ZG5HPPM-6TKTH5V-L6BZFUC-4OROOAA";
          autoAcceptFolders = true;
        };
      };
      folders = {
        "knowledge_base" = {
          path = myconf.knowledge_base;
          devices = [
            "pixel9a"
            "faye"
            "jet"
          ];
        };
        "hexis" = {
          path = myconf.hexis_path;
          devices = [
            "faye"
            "jet"
          ];
        };
      };
    };
  };
}
