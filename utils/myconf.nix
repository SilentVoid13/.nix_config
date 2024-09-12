{...}: rec {
  username = "silent";
  knowledge_base = "/home/${username}/quark";
  monitor1 = "<mon1>";
  monitor2 = "<mon2>";

  git = {
    personal = {
      name = "silentvoid13";
      email = "51264226+SilentVoid13@users.noreply.github.com";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4upjUw/TdQOTnUSdhH6DAfdLyJE1VRd/ZvV4eBqjIY";
    };
    work = {
      name = "<name>";
      email = "<mail>";
      key = "<key>";
      host = "<host>";
    };
  };
}
