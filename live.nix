{ config, lib, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix>
  ];

  boot.supportedFilesystems = [ "bcachefs" "vfat" ];
  boot.kernelPackages = pkgs.linuxPackages_testing;

  environment.systemPackages = with pkgs; [
    pkgs.gnome-console
    pkgs.gnome.nautilus
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    # open = true;
  };

  isoImage.squashfsCompression = "zstd";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [(final: super: {
    zfs = super.zfs.overrideAttrs(_: {
      meta.platforms = [];
    });
  })];

  services.gnome.core-utilities.enable = false;
  services.xserver.videoDrivers = [ "nvidia" ];
}
