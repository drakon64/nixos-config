{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix>
  ];

  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_testing;
    supportedFilesystems = [ "bcachefs" ];
  };

  environment.systemPackages = with pkgs; [
    vim
  ];

  hardware = {
    nvidia.modesetting.enable = true;
  };

  isoImage.squashfsCompression = "zstd";

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [(final: super: {
      zfs = super.zfs.overrideAttrs(_: {
        meta.platforms = [];
      });
    })];
  };

  services = {
    openssh.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
  };

  users.users.nixos = {
    initialHashedPassword = lib.mkForce null;
    initialPassword = "nixos";
  };
}
