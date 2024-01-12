{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
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
    ];
  };

  hardware.opengl.driSupport32Bit = true;

  programs = {
    _1password-gui.enable = true;
    gamemode.enable = true;
    steam.enable = true;
  };

  # services.openssh.enable = true;

  users.users.adamc = {
    description = "Adam Chance";
    extraGroups = [ "networkmanager" "wheel" ];
    isNormalUser = true;
  };
}
