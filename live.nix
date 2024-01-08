{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix>
    ./configuration.nix
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_testing;

  isoImage.squashfsCompression = "zstd";

  services.openssh.enable = true;

  users.users.nixos = {
    initialHashedPassword = lib.mkForce null;
    initialPassword = "nixos";
  };
}
