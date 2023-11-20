{ config, lib, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix>
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "bcachefs" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [(final: super: {
    zfs = super.zfs.overrideAttrs(_: {
      meta.platforms = [];
    });
  })];

  services.xserver.videoDrivers = [ "nvidia" ];
}
