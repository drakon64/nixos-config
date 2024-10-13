{
  config,
  pkgs,
  lib,
  ...
}:

{
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
