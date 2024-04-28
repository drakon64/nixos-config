{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./home.nix
    ./unstable.nix
    ./xivlauncher.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_8;

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot.enable = true;
    };

    supportedFilesystems = [ "bcachefs" ];
    # TODO: Enable this in NixOS 24.05
    #supportedFilesystems = {
    #  bcachefs = true;
    #  zfs = lib.mkForce false;
    #};
  };

  console.keyMap = "uk";

  documentation.nixos.enable = false;

  environment = {
    gnome.excludePackages = with pkgs; [
      epiphany
      evince
      gnome-connections
      gnome.geary
      gnome.gnome-calendar
      gnome.gnome-characters
      gnome.gnome-clocks
      gnome.gnome-contacts
      gnome.gnome-font-viewer
      gnome.gnome-maps
      gnome.gnome-music
      gnome.simple-scan
      gnome.gnome-software
      gnome-tour
      gnome.yelp
      snapshot
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
    };

    systemPackages = with pkgs; [
      discord
      ffmpeg
      firefox
      gnome.gnome-boxes
      jetbrains.idea-ultimate
      mangohud
      # r2modman
      spotify
      vim
      # xivlauncher

      gnomeExtensions.alphabetical-app-grid
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.gamemode-indicator-in-system-settings

      (wrapOBS {
        plugins = with obs-studio-plugins; [
          obs-pipewire-audio-capture
          obs-vkcapture
        ];
      })
    ];
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;

      open = false;
    };

    pulseaudio.enable = false;
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
    hostName = "desktop";

    networkmanager.enable = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };

    # TODO: Disable this in NixOS 24.05
    overlays = [(final: super: {
      zfs = super.zfs.overrideAttrs(_: {
        meta.platforms = [];
      });
    })];
  };

  programs = {
    _1password-gui.enable = true;

    gamemode = {
      enable = true;

      settings.general.renice = 20;
    };

    steam = {
      enable = true;

      package = pkgs.steam.override {
        extraEnv = {
          MANGOHUD = true;
          OBS_VKCAPTURE = true;
        };

        extraPkgs = pkgs: with pkgs; [
          gamemode
          mangohud
        ];
      };
    };
  };

  services = {
    flatpak.enable = true;

    fwupd.enable = true;

    pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;
    };

    xserver = {
      enable = true;

      excludePackages = [ pkgs.xterm ];

      displayManager.gdm.enable = true;

      desktopManager.gnome.enable = true;

      layout = "gb";
      videoDrivers = [ "nvidia" ];
      xkbVariant = "";
    };
  };

  security.rtkit.enable = true;

  sound.enable = true;

  system.stateVersion = "23.11";

  time.timeZone = "Europe/London";

  users.users.adamc = {
    description = "Adam Chance";
    extraGroups = [ "gamemode" "libvirtd" "networkmanager" "wheel" ];
    isNormalUser = true;
  };

  virtualisation.libvirtd.enable = true;
}
