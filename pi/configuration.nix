{
  lib,
  modulesPath,
  pkgs,
  ipxe,
  netboot,
  ...
}:
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
  nixpkgs.hostPlatform = "aarch64-linux";

  programs.vim = {
    enable = true;

    defaultEditor = true;
  };

  services = {
    atftpd = {
      enable = true;

      root = ipxe;
    };

    caddy = {
      enable = true;

      configFile =
        let
          ipxeChain =
            let
              netbootBuild = netboot.config.system.build;
            in
            pkgs.symlinkJoin {
              name = "netboot";

              paths = [
                netbootBuild.netbootRamdisk
                netbootBuild.kernel
                netbootBuild.netbootIpxeScript
              ];
            };
        in
        pkgs.writeText "Caddyfile" ''
          http://192.168.2.2

          root * ${ipxeChain}
          file_server
        '';
    };
  };

  system.stateVersion = "24.11";

  users.users.adamc = {
    description = "Adam Chance";
    extraGroups = [ "wheel" ];
    initialPassword = "nixos";
    isNormalUser = true;
  };
}
