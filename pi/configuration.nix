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
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  system.stateVersion = "24.05";

  users.users.adamc = {
    description = "Adam Chance";
    extraGroups = [ "wheel" ];
    initialPassword = "nixos";
    isNormalUser = true;
  };
}
