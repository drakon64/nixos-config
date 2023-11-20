{ config, lib, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix>
  ];

  boot.supportedFilesystems = [ "bcachefs" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
