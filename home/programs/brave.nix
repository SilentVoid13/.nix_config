{
  config,
  pkgs,
  ...
}: let
  home = config.home.homeDirectory;
  extText = builtins.toJSON {
    external_update_url = "https://clients2.google.com/service/update2/crx";
  };
  extDir = "BraveSoftware/Brave-Browser/External Extensions";
  extList = {
    _1password = "aeblfdkhhhdcdjpifhhbdiojplfjncoa";
    vimium = "dbepggeogbaibhgnhhndojpepiihcmeb";
    foxyproxy = "gcknhkkoolaabfmlnjonogaaifnjlfnp";
    editthiscookie = "fngmhnnpilhplaeedifhccceomclgfbg";
    ublock = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
    wappalyzer = "gppongmhjkpfnbhagpmjfkannfbllamg";
    blocksite = "bjcnpgekponkjpincbcoflgkdomldlnl";
    sponsorblock = "mnjggcdmjocbbbhaepdhchncahnbgone";
    cookieautodelete = "fhcgjolkccmbidfldomjliifgaodjagh";
    clearurls = "lckanjgmijmafbedllaakclkaicjfmnk";
  };
in {
  home.packages = with pkgs; [
    brave
  ];
  xdg = {
    enable = true;
    configFile = {
      "${extDir}/${extList.vimium}.json".text = extText;
      "${extDir}/${extList._1password}.json".text = extText;
      "${extDir}/${extList.foxyproxy}.json".text = extText;
      "${extDir}/${extList.editthiscookie}.json".text = extText;
      "${extDir}/${extList.ublock}.json".text = extText;
      "${extDir}/${extList.wappalyzer}.json".text = extText;
      "${extDir}/${extList.blocksite}.json".text = extText;
      "${extDir}/${extList.sponsorblock}.json".text = extText;
      "${extDir}/${extList.clearurls}.json".text = extText;
    };
  };
}
