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
    binfmt.emulatedSystems = [ "aarch64-linux" ];

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
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
    };

    systemPackages = with pkgs; [
      bcachefs-tools
      discord
      element-desktop
      file-roller
      nixfmt-rfc-style
      spotify
      vim
      virt-viewer

      cosmic-ext-observatory
      cosmic-player

      dotnetCorePackages.dotnet_9.sdk
      jetbrains.rider

      (inputs.nixos-xivlauncher-rb.packages.x86_64-linux.default.override {
        nvngxPath = "${config.hardware.nvidia.package}/lib/nvidia/wine";
      })

      jetbrains.idea-community

      (pkgs.callPackage ./krisp-patcher.nix { })

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
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  i18n.defaultLocale = "en_GB.UTF-8";

  networking.hostName = "desktop";

  nix.settings = {
    auto-optimise-store = true;

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    substituters = [
      "https://drakon64-nixos-cosmic.cachix.org"
      "https://cosmic.cachix.org/"
    ];

    trusted-public-keys = [
      "drakon64-nixos-cosmic.cachix.org-1:bW2gsh5pbdMxcI3sklvtROM9A8CXtPXgVwmIcO3E3io="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    _1password-gui = {
      enable = true;

      polkitPolicyOwners = [ "adamc" ];
    };

    firefox = {
      enable = true;

      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };

    gamescope.enable = true;

    steam = {
      enable = true;

      gamescopeSession.enable = true;

      package = pkgs.steam.override {
        extraEnv = {
          MANGOHUD = true;
          OBS_VKCAPTURE = true;
        };
      };
    };

    vim = {
      enable = true;

      defaultEditor = true;
    };

    virt-manager.enable = true;
  };

  services = {
    desktopManager.cosmic.enable = true;

    displayManager = {
      autoLogin.user = "adamc";
      cosmic-greeter.enable = true;
    };

    fwupd.enable = true;

    xserver = {
      videoDrivers = [ "nvidia" ];
      xkb.layout = "gb";
    };
  };

  system.stateVersion = "24.11";

  time.timeZone = "Europe/London";

  users.users.adamc = {
    description = "Adam Chance";

    extraGroups = [
      "libvirtd"
      "networkmanager"
      "wheel"
    ];

    isNormalUser = true;
  };

  virtualisation.libvirtd.enable = true;
}
