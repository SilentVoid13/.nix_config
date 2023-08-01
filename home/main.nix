{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = builtins.concatMap import [
    ./programs
    ./services
  ];
}
