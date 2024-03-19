{ config, pkgs, ... }:

let
  nr-ryantm = import
    (builtins.fetchTarball hhttps://github.com/r-ryantm/nixpkgs/archive/9653c6ec84c8d56fffd5480533f5bde4c943e54e.tar.gz)
    { config = config.nixpkgs.config; };
in
{
  environment.systemPackages = with pkgs; [
    nr-ryantm.xivlauncher
  ];
}
