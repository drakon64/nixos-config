{ config, pkgs, ... }:

{
  imports = [
#    ./hardware-configuration.nix
    ./unstable.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot.enable = true;
    };

    supportedFilesystems = [ "bcachefs" ];
  };

  console.keyMap = "uk";

  documentation.nixos.enable = false;

  environment = {
    gnome.excludePackages = with pkgs; [
      epiphany
      gnome.geary
      gnome.gnome-calendar
      gnome.gnome-characters
      gnome.gnome-clocks
      gnome.gnome-contacts
      gnome.gnome-font-viewer
      gnome.gnome-maps
      gnome.gnome-music
      gnome.simple-scan
      gnome-connections
      gnome-tour
      gnome.yelp
      snapshot
    ];

    sessionVariables.NIXOS_OZONE_WL = "1";

    systemPackages = with pkgs; [
      discord
      ffmpeg
      firefox
      jetbrains.idea-ultimate
      # r2modman
      vim
      # webcord
      xivlauncher

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
    nvidia.modesetting.enable = true;

    opengl.driSupport32Bit = true;

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
    config.allowUnfree = true;

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

      gamescopeSession.enable = true;
    };
  };

  services = {
    openssh.enable = false;

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
    extraGroups = [ "gamemode" "networkmanager" "wheel" ];
    isNormalUser = true;
  };
}
