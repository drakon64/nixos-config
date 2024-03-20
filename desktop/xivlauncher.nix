{ config, pkgs, ... }:

let
  release = import
    (builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/8a26e1beb022d7e9a22d86cbbe1c444b68ebe4a4.tar.gz)
    { config = config.nixpkgs.config; };
in
{
  environment.systemPackages = with pkgs; [
    release.xivlauncher
  ];
}
