{ lib, modulesPath, ... }:
{
  imports = [ "${modulesPath}/installer/sd-card/sd-image-aarch64.nix" ];

  boot = {
    binfmt.emulatedSystems = [ "x86_64-linux" ];
    supportedFilesystems.zfs = lib.mkForce false;
  };

  console.keyMap = "uk";
  documentation.nixos.enable = false;

  fileSystems = {
    "/boot/firmware".options = [ "discard" ];
    "/".options = [ "discard" ];
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  networking.hostName = "pi";
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  programs.vim = {
    enable = true;

    defaultEditor = true;
  };

  system.stateVersion = "24.11";

  users.users.adamc = {
    description = "Adam Chance";
    extraGroups = [ "wheel" ];
    initialPassword = "nixos";
    isNormalUser = true;
  };
}
