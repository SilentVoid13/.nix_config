{ ... }:
rec {
  username = "silent";
  knowledge_base = "/home/${username}/kb";
  project_folders = [
    "/home/${username}/H/p"
    "/home/${username}/H/r"
    "/home/${username}/H/t"
  ];
  monitor1 = "DP-2";
  monitor2 = "eDP-1";
  git = {
    personal = {
      name = "";
      email = "";
      key = "";
    };
    work = {
      name = "";
      email = "";
      key = "";
      host = "";
    };
  };
}
