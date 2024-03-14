{ config, lib, pkgs, ... }:

{
#  imports = [
#    ./hardware-configuration.nix
#  ];

  boot = {
    # TODO: Remove this when an LTS kernel is released with bcachefs support
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot.enable = true;
    };

    supportedFilesystems = {
      bcachefs = true;
      zfs = lib.mkForce false;
    };
  };

  console.keyMap = "uk";

  documentation.nixos.enable = false;

  environment = {
    gnome.excludePackages = with pkgs; [
      epiphany
      gnome.gnome-characters
      gnome.gnome-clocks
      gnome.gnome-font-viewer
      gnome.gnome-maps
      gnome.gnome-music
      gnome.simple-scan
      gnome-tour
      gnome.yelp
      snapshot
    ];

    systemPackages = with pkgs; [
      gnome.gnome-boxes
      jetbrains.idea-ultimate
      microsoft-edge
      python312
      vim

      gnomeExtensions.alphabetical-app-grid
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
    ];
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;

      open = true;
    };

    pulseaudio.enable = lib.mkForce false;
  };

  i18n = {
    defaultLocale = "en_GB.UTF-8";

    extraLocaleSettings = {
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
  };

  networking = {
    hostName = "work-laptop";

    networkmanager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  services = {
    pipewire = {
      enable = true;

      alsa.enable = true;

      pulse.enable = true;
    };

    xserver = {
      enable = true;

      excludePackages = [ pkgs.xterm ];

      displayManager.gdm.enable = true;

      desktopManager.gnome.enable = true;

      videoDrivers = [ "nvidia" ];

      xkb = {
        layout = "gb";
        variant = "";
      };
    };
  };

  security.rtkit.enable = true;

  sound.enable = true;

  system.stateVersion = "23.11";

  time.timeZone = "Europe/London";

  users.users.adamc = {
    description = "Adam Chance";
    extraGroups = [ "libvirtd" "networkmanager" "wheel" ];
    isNormalUser = true;
  };

  virtualisation.libvirtd.enable = true;
}
