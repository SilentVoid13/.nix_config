{ pkgs ? import <nixpkgs> {} }:
(pkgs.buildFHSUserEnv {
    name = "fhs_env";
    targetPkgs = pkgs: with pkgs; [];
}).env
