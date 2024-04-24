{ config, pkgs, ... }:

let
  rb = import
    (builtins.fetchTarball https://github.com/drakon64/nixpkgs/archive/22b2f6e841b179d4947ab6e0fdd2b612de0ec1bf.tar.gz)
    { config = config.nixpkgs.config; };
in {
  environment.systemPackages = with pkgs; [
    (rb.xivlauncher.override {
      useGameMode = true;
      useRbPatchedLauncher = true;
    })
  ];
}
