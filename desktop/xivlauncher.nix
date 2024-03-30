{ config, pkgs, ... }:

let
  rb = import
    (builtins.fetchTarball https://github.com/drakon64/nixpkgs/archive/16c3c6a39b0f3f6d0bf3cbc036b10394d0374a7b.tar.gz)
    { config = config.nixpkgs.config; };
in {
  environment.systemPackages = with pkgs; [
    (rb.xivlauncher.override {
      useGameMode = true;
      useRbPatchedLauncher = true;
    })
  ];
}
