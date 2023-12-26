{ config, lib, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix>
  ];

  boot.kernelPackages = pkgs.linuxPackages_testing;
  boot.supportedFilesystems = lib.mkForce [ "bcachefs" "vfat" ];

  environment.systemPackages = with pkgs; [
    pkgs.gnome-console
    pkgs.gnome.file-roller
    pkgs.gnome.nautilus
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    # open = true;
  };

  nixpkgs.config.allowUnfree = true;

  services.gnome.core-utilities.enable = false;
  services.xserver.videoDrivers = [ "nvidia" ];
}
