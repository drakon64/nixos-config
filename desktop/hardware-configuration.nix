{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    extraModulePackages = [ ];

    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "usbhid"
        "usb_storage"
        "xhci_pci"
      ];

      kernelModules = [ ];
    };

    kernelModules = [ "kvm-amd" ];
  };

  fileSystems = {
    "/" = {
      device = "UUID=6b12b6cd-4dc4-48b8-a2b0-89ff5be6fd42";
      fsType = "bcachefs";
      options = [ "discard" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/3846-1C3C";
      fsType = "vfat";

      options = [
        "fmask=0077"
        "dmask=0077"
        "discard"
      ];
    };
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  swapDevices = [ ];
}
