{ lib, modulesPath, ... }:
{
  imports = [ "${modulesPath}/installer/netboot/netboot.nix" ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "24.11";
}
