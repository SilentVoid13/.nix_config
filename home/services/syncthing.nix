{myconf, ...}: {
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        "pixel7a" = {id = "CNZLAZG-OH6B3H5-XFRGL3O-W6DFIR3-ALFOWUW-6UJMQDB-SEENXU7-XAP3HAT";};
        "faye" = {id = "U5WYFHI-A7U57P4-ITTP6OD-43GXCIA-VTLU7TJ-RITZMOQ-ZXA7HLQ-HICBFAH";};
        "jet" = {id = "4HMBYZE-HSQ4SSF-ZVLPVHQ-YNUL2HS-ZG5HPPM-6TKTH5V-L6BZFUC-4OROOAA";};
      };
      folders = {
        "knowledge_base" = {
          path = myconf.knowledge_base;
        };
      };
    };
  };
}
