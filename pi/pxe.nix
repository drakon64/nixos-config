{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
}
