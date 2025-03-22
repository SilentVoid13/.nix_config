{ pkgs ? import <nixpkgs> {} }:
(pkgs.buildFHSEnv {
    name = "fhs_env";
    targetPkgs = pkgs: with pkgs; [];
}).env
