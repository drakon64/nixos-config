{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];

  users.users.adamc = {
    description = "Adam Chance";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "nixos";
    isNormalUser = true;
  };
}
