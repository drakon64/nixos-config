# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    "${modulesPath}/installer/netboot/netboot-base.nix"

    ../common/lix.nix
  ];

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  services.desktopManager.cosmic = {
    enable = true;

    xwayland.enable = false;
  };

  services.displayManager = {
    autoLogin.user = "nixos";
    cosmic-greeter.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixos = {
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    isNormalUser = true;
    password = "nixos";
    shell = pkgs.fish;
  };

  programs = {
    firefox.enable = true;

    fish.enable = true;

    vim = {
      enable = true;

      defaultEditor = true;
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "${config.system.nixos.release}"; # Did you read the comment?
}
