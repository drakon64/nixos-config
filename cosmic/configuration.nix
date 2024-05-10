{ config, lib, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_6_8;

    supportedFilesystems.zfs = lib.mkForce false;
  };

  documentation = {
    doc.enable = lib.mkForce false;

    man.enable = lib.mkForce false;
  };

  environment.noXlibs = lib.mkForce true;

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

    xserver.videoDrivers = [ "virtualbox" "vmware" "cirrus" "vesa" "modesetting" ];
  };

  users.users.nixos.extraGroups = [ "vboxsf" ];

  virtualisation.virtualbox.guest.enable = lib.mkForce true;
}
