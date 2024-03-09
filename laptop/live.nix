{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix>
    ./configuration.nix
  ];

  isoImage.squashfsCompression = "zstd";

  services = {
    openssh.enable = true;

    xserver.displayManager.autoLogin.user = lib.mkForce "adamc";
  };

  users.users.adamc = {
    initialHashedPassword = lib.mkForce null;
    initialPassword = "nixos";
  };
}
