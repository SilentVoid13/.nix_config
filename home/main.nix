{
  config,
  pkgs,
  ...
}: {
  imports = builtins.concatMap import [
    ./programs
    ./services
  ];
}
