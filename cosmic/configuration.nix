{ config, lib, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_6_8;

    loader.grub.memtest86.enable = lib.mkForce false;

    supportedFilesystems.zfs = lib.mkForce false;
  };

  hardware.pulseaudio.enable = lib.mkForce false;

  isoImage.edition = lib.mkForce "cosmic";

  networking.hostName = "cosmic";

  nixpkgs.hostPlatform = "x86_64-linux";

  services = {
    desktopManager.cosmic.enable = true;

    displayManager = {
      autoLogin = {
        enable = true;

        user = "nixos";
      };

      cosmic-greeter.enable = true;
    };

    qemuGuest.enable = lib.mkForce false;

    spice-vdagentd.enable = lib.mkForce false;

    xe-guest-utilities.enable = lib.mkForce false;

    xserver.excludePackages = [ pkgs.xterm ];
  };

  virtualisation = {
    hypervGuest.enable = lib.mkForce false;

    vmware.guest.enable = lib.mkForce false;
  };
}
