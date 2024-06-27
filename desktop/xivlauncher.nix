{ config, pkgs, ... }:

let
  rb = import
    (builtins.fetchTarball https://github.com/sersorrel/nixpkgs/archive/86555373894cba05cdbbb274d9b412b87e76ad98.tar.gz)
    { config = config.nixpkgs.config; };
in {
  environment.systemPackages = with pkgs; [
    (rb.xivlauncher.override {
#      useGameMode = true;
#      useRbPatchedLauncher = true;
    })
  ];
}
