{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [ "${modulesPath}/installer/sd-card/sd-image-aarch64.nix" ];
  
  system.stateVersion = "25.11";
}
