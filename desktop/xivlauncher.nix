{ config, pkgs, ... }:

let
  rb = import
    (builtins.fetchTarball https://github.com/drakon64/nixpkgs/archive/6d1432f091f8cf7cda25568a602014043755d5a6.tar.gz)
    { config = config.nixpkgs.config; };
in {
  environment.systemPackages = with pkgs; [
    (rb.xivlauncher.override {
      useGameMode = true;
      useRbPatchedLauncher = true;
    })
  ];
}
