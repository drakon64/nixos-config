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
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ ];
    };

    kernelModules = [ "kvm-amd" ];

    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "UUID=70335a84-bdcb-4a88-a2ca-46c49e508946";
      fsType = "bcachefs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/9921-36F9";
      fsType = "vfat";
    };
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  swapDevices = [ ];
}
