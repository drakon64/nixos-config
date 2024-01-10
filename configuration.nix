{ config, lib, pkgs, ... }:

{
  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  console.keyMap = "uk";

  sound.enable = true;
  hardware.pulseaudio.enable = lib.mkForce false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "bcachefs" ];
  };

  environment = {
    gnome.excludePackages = with pkgs; [
      epiphany
      gnome.geary
      gnome.gnome-calendar
      gnome.gnome-clocks
      gnome.gnome-contacts
      gnome.gnome-maps
      gnome.gnome-music
      gnome.simple-scan
      gnome-tour
      gnome.yelp
      snapshot
    ];
    systemPackages = with pkgs; [
      firefox
      vim
    ];
  };

  hardware.nvidia.modesetting.enable = true;

  nixpkgs.overlays = [(final: super: {
    zfs = super.zfs.overrideAttrs(_: {
      meta.platforms = [];
    });
  })];

  services.xserver.videoDrivers = [ "nvidia" ];
}
