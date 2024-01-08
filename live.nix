{ config, lib, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix>
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.systemPackages = with pkgs; [
    bcachefs-tools
    vim
  ];

  isoImage.squashfsCompression = "zstd -22 --ultra";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [(final: super: {
    zfs = super.zfs.overrideAttrs(_: {
      meta.platforms = [];
    });
  })];

  services.openssh.enable = true;

  users.users.nixos = {
    initialHashedPassword = null;
    initialPassword = "nixos";
  };
}
