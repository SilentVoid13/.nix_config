{pkgs}: {
  qwerty_fr = pkgs.callPackage ./qwerty-fr {inherit pkgs;};
}
