{ config, pkgs, ... }:

let
  rb = import
    (builtins.fetchTarball https://github.com/drakon64/nixpkgs/archive/dad6d4c6db6a1c135533eb80978dce75ac6bb3ab.tar.gz)
    { config = config.nixpkgs.config; };
in {
  environment.systemPackages = with pkgs; [
    rb.xivlauncher-rb
  ];
}
