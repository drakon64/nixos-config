{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./r2modman.nix
    ./configuration.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages = with pkgs; [
      discord
      ffmpeg
      helvum
      jetbrains.idea-ultimate
      obs-studio
      # r2modman
      xivlauncher

      gnomeExtensions.alphabetical-app-grid
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.gamemode-indicator-in-system-settings
    ];
  };

  hardware.opengl.driSupport32Bit = true;

  programs = {
    _1password-gui.enable = true;

    gamemode = {
      enable = true;

      settings.general = {
        renice = 20;
      };
    };

    steam.enable = true;
  };

  # services.openssh.enable = true;

  users.users.adamc = {
    description = "Adam Chance";
    extraGroups = [ "gamemode" "networkmanager" "wheel" ];
    isNormalUser = true;
  };
}
