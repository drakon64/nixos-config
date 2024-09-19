{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
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

  time.timeZone = "Europe/London";

  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
  };

  environment.systemPackages = with pkgs; [
    discord
    element-desktop
    firefox
    jetbrains.idea-ultimate
    nixfmt-rfc-style
    vim
    wget
  ];

  hardware.opengl = {
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.amdvlk ];
  };

  nix.settings = {
    auto-optimise-store = true;
    cores = 8;

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    max-jobs = 8;

    substituters = [
      "https://cosmic.cachix.org/"
      "https://drakon64-nixos-cosmic.cachix.org/"
    ];

    trusted-public-keys = [
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "drakon64-nixos-cosmic.cachix.org-1:bW2gsh5pbdMxcI3sklvtROM9A8CXtPXgVwmIcO3E3io="
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    _1password-gui.enable = true;

    steam.enable = true;
  };

  services = {
    fwupd.enable = true;

    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
      xkb.layout = "gb";
    };
  };

  system.stateVersion = "24.05";

  users.users.adamc = {
    description = "Adam Chance";

    extraGroups = [
      "networkmanager"
      "wheel"
    ];

    isNormalUser = true;
  };
}
