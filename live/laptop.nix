{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix>
    ../laptop.nix
  ];

  isoImage.squashfsCompression = "zstd";

  services.openssh.enable = true;

  users.users.adamc = {
    initialHashedPassword = lib.mkForce null;
    initialPassword = "nixos";
  };
}
