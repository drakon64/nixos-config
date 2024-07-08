{ config, pkgs, ... }:

let
  rb = import
    (builtins.fetchTarball https://github.com/drakon64/nixpkgs/archive/f1f87de3fd5f18f18e7b5cea15d288086c929694.tar.gz)
    { config = config.nixpkgs.config; };
in {
  environment.systemPackages = with pkgs; [
    (rb.xivlauncher.override {
      useGameMode = true;
      useRbPatchedLauncher = true;
    })
  ];
}
