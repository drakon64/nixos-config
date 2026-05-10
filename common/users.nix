{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  programs.fish.enable = true;

  users.users.evelyn = {
    extraGroups = [ "wheel" ];
    initialPassword = "nixos";
    isNormalUser = true;
    shell = pkgs.fish;
  };
}
