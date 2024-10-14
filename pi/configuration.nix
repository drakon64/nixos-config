{
  config,
  pkgs,
  lib,
  ...
}:
{
  boot.supportedFilesystems = {
    ext4 = true;
    zfs = lib.mkForce false;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  hardware.enableRedistributableFirmware = true;
  nixpkgs.crossSystem.config = "aarch64-unknown-linux-gnu";
  system.stateVersion = "24.05";

  users.users.nixos = {
    extraGroups = [ "wheel" ];
    initialPassword = "nixos";
    isNormalUser = true;
  };
}
