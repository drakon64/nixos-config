{ config, pkgs, ... }:

let
  rb = import
    (builtins.fetchTarball https://github.com/drakon64/nixpkgs/archive/bf514a1ea654811b459818a8a1a1714848dbde78.tar.gz)
    { config = config.nixpkgs.config; };
in {
  environment.systemPackages = with pkgs; [
    (rb.xivlauncher.override {
      useGameMode = true;
    })
  ];
}
