{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_11;

    kernelParams = [ "nvidia_drm.fbdev=1" ];

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
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "0";
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
    };

    systemPackages = with pkgs; [
      cosmic-player
      discord
      element-desktop
      ffmpeg
      firefox
      gimp
      gnome.file-roller
      gnome.gnome-system-monitor
      jetbrains.idea-ultimate
      killall
      libimobiledevice
      mangohud
      nixfmt-rfc-style
      r2modman
      spotify
      vim
      yt-dlp

      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.pop-shell

      (inputs.nixos-xivlauncher-rb.packages.x86_64-linux.default.override {
        useGameMode = true;
        nvngxPath = "${config.hardware.nvidia.package}/lib/nvidia/wine";
      })

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

      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "555.58.02";
        sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
        sha256_aarch64 = lib.fakeSha256;
        openSha256 = lib.fakeSha256;
        settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
        persistencedSha256 = lib.fakeSha256;
      };
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

  nix.settings = {
    auto-optimise-store = true;
    cores = 15;

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    max-jobs = 15;
    substituters = [ "https://cosmic.cachix.org/" ];
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };

  nixpkgs.config.allowUnfree = true;

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
          NIXOS_OZONE_WL = false;
          OBS_VKCAPTURE = true;
          SDL_VIDEODRIVER = "x11";
        };
      };
    };
  };

  services = {
    desktopManager.cosmic.enable = true;
    xserver.desktopManager.gnome.enable = true;
    displayManager.cosmic-greeter.enable = true;
    fwupd.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };

    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
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

    extraGroups = [
      "gamemode"
      "networkmanager"
      "wheel"
    ];

    isNormalUser = true;
  };
}
