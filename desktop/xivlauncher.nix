{ config, pkgs, ... }:

let
  tz = import
    (builtins.fetchTarball https://github.com/witchof0x20/nixpkgs/archive/931562ee7b06547aa76838dada36cacc71b3b61a.tar.gz)
    { config = config.nixpkgs.config; };
in
{
  environment.systemPackages = with pkgs; [
    tz.xivlauncher
  ];
}
