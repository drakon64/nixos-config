{
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [ "${modulesPath}/installer/netboot/netboot-minimal.nix" ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    supportedFilesystems = {
      bcachefs = true;
      zfs = lib.mkForce false;
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "24.11";
}
