{ config, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  home = {
    homeDirectory = "/home/adamc";
    stateVersion = "24.05";
    username = "adamc";
  };

  programs.home-manager.enable = true;
}
