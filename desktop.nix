{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  }

  environment.systemPackages = with pkgs; [
    _1password-gui
    discord
    ffmpeg
    # r2modman
    xivlauncher

    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
  ];

  hardware.opengl.driSupport32Bit = true;

  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  # services.openssh.enable = true;

  users.users.adamc = {
    description = "Adam Chance";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "nixos";
    isNormalUser = true;
  };
}
