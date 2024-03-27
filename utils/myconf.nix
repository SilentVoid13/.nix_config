{...}: let
    username = "silent";
    knowledge_base = "/home/${username}/quark";
in  {
    inherit username;
    inherit knowledge_base;
}
