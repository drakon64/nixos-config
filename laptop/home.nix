{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home = {
    homeDirectory = "/home/adamc";
    stateVersion = "23.11";
    username = "adamc";
  };

  programs.home-manager.enable = true;
}
