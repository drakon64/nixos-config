{ config, lib, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_6_8;
    kernelParams = [ "nvidia_drm.fbdev=1" ];
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;

      open = true;
    };

    pulseaudio.enable = lib.mkForce false;
  };

  networking.hostName = "cosmic";

  nixpkgs = {
    config.allowUnfree = true;

    hostPlatform = "x86_64-linux";
  };

  services = {
    desktopManager.cosmic.enable = true;

    displayManager = {
      autoLogin = {
        enable = true;

        user = "nixos";
      };

      cosmic-greeter.enable = true;
    };

    xserver.videoDrivers = [ "nvidia" ];
  };

  system.stateVersion = "24.05";
}
