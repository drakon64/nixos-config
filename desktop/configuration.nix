{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_10;

    kernelParams = [
      "amd_pstate=active"
      "initcall_blacklist=acpi_cpufreq_init"
      "nvidia_drm.fbdev=1"
    ];

    # https://github.com/NixOS/nixpkgs/pull/330917
    kernelPatches = [
      {
        name = "cachyos-base-all";

        patch = (
          pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/f036a67118ed302c3611e82e0234f8d4279079af/6.10/all/0001-cachyos-base-all.patch";
            hash = "sha256-lZbElRTvhc6u6rEQAbpdRSPLUj/rPTqKX1ZFdMTMZlo=";
          }
        );

        extraStructuredConfig = with lib.kernel; {
          #GENERIC_CPU = no;
          #ZNVER3 = yes;

          CACHY = yes;

          LTO_NONE = yes;

          HZ_300 = no;
          HZ_1000 = yes;
          HZ = freeform "1000";

          NR_CPUS = freeform "16";

          HZ_PERIODIC = no;
          NO_HZ_IDLE = no;
          CONTEXT_TRACKING_FORCE = no;
          NO_HZ_FULL_NODEF = yes;
          NO_HZ_FULL = yes;
          NO_HZ = yes;
          NO_HZ_COMMON = yes;
          CONTEXT_TRACKING = yes;

          PREEMPT_BUILD = yes;
          PREEMPT_NONE = no;
          PREEMPT_VOLUNTARY = no;
          PREEMPT = yes;
          PREEMPT_COUNT = yes;
          PREEMPTION = yes;
          PREEMPT_DYNAMIC = yes;

          CC_OPTIMIZE_FOR_PERFORMANCE = no;
          CC_OPTIMIZE_FOR_PERFORMANCE_O3 = yes;

          TCP_CONG_CUBIC = module;
          DEFAULT_CUBIC = no;
          TCP_CONG_BBR = yes;
          DEFAULT_BBR = yes;
          DEFAULT_TCP_CONG = freeform "bbr";

          TRANSPARENT_HUGEPAGE_MADVISE = no;
          TRANSPARENT_HUGEPAGE_ALWAYS = yes;

          USER_NS = yes;
        };
      }
      {
        name = "sched-ext";

        patch = (
          pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/f036a67118ed302c3611e82e0234f8d4279079af/6.10/sched/0001-sched-ext.patch";
            hash = "sha256-VHuXqMEHCaGXTOaN4df1Ey6+D1T0SFtFJrClI7FBBZA=";
          }
        );

        extraStructuredConfig = with lib.kernel; {
          BPF = yes;
          SCHED_CLASS_EXT = yes;
          BPF_SYSCALL = yes;
          BPF_JIT = yes;
          DEBUG_INFO_BTF = yes;
          BPF_JIT_ALWAYS_ON = yes;
          BPF_JIT_DEFAULT_ON = yes;
          PAHOLE_HAS_SPLIT_BTF = yes;
          PAHOLE_HAS_BTF_TAG = yes;
        };
      }
      {
        name = "bore-cachy-ext";

        patch = (
          pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/f036a67118ed302c3611e82e0234f8d4279079af/6.10/sched/0001-bore-cachy-ext.patch";
            hash = "sha256-kl/wLeR/Yuh5itoJfIkldtRtKYL5EXKwc7WI59T4DAA=";
          }
        );

        extraStructuredConfig = with lib.kernel; {
          SCHED_BORE = yes;
          MIN_BASE_SLICE_NS = freeform "1000000";
        };
      }
    ];

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
      gnome-tour
      gnome.yelp
      snapshot
    ];

    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "0";
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
    };

    systemPackages = with pkgs; [
      discord
      element-desktop
      ffmpeg
      firefox
      jetbrains.idea-ultimate
      killall
      mangohud
      r2modman
      spotify
      vim
      yt-dlp

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

  fileSystems."/home/adamc/Left 4 Dead 2" = {
    device = "/home/adamc/l4d2.img";
    fsType = "ext4";
    options = [ "loop" ];
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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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
    # desktopManager.cosmic.enable = true;

    # displayManager.cosmic-greeter.enable = true;

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
