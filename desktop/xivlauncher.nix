{ config, pkgs, ... }:

let
  rb = import
    (builtins.fetchTarball https://github.com/drakon64/nixpkgs/archive/492175b3b8f22792199a417da10a59d0c7ab17bf.tar.gz)
    { config = config.nixpkgs.config; };
in {
  environment.systemPackages = with pkgs; [
    (rb.xivlauncher.override {
      useGameMode = true;
      useRbPatchedLauncher = true;
    })
  ];
}
