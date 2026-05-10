{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"

    ../common/lix.nix
    ../common/users.nix

    ./pxe.nix
  ];

  console.keyMap = "uk";

  i18n.defaultLocale = "en_GB.UTF-8";

  networking.hostName = "pi";

  services.openssh.enable = true;

  system.stateVersion = "25.11";

  time.timeZone = "Europe/London";
}
