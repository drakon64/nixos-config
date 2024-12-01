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
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];

      kernelModules = [ "dm-snapshot" ];

      luks.devices."root" = {
        device = "/dev/disk/by-uuid/bd4eb8c7-22a8-4338-b8d4-ea4b6f2270e7";
        preLVM = true;
        allowDiscards = true;
      };
    };

    kernelModules = [ "kvm-amd" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/5ff28333-a4ab-40be-84dc-9a6f56a17ce3";
      fsType = "xfs";
      options = [ "discard" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/B053-4CD8";
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
