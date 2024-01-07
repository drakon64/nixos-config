{ config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
  ];

  boot = {
    binfmt.emulatedSystems = [ "x86_64-linux" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  containers.pxe = {
    autostart = true;
    extraFlags = [ "-U" ];

    config = { config, pkgs, ... }: {
      services.caddy = {
        enable = true;

        virtualHosts."http://localhost".extraConfig = ''
          respond "#!ipxe
          "
        '';
      };

      services.dnsmasq = {
        enable = true;

        settings = {
          dhcp-range = "192.168.1.2,proxy";
          dhcp-userclass = "set:iPXE,iPXE";
          dhcp-boot = "tag:!iPXE,snponly.efi,192.168.1.2";
          dhcp-boot = "tag:iPXE,http://192.168.1.2/boot.ipxe";

          interface = bind-dynamic;
          port = 0;
        };
      };

      system.stateVersion = "23.11";
    };
  };

  system.stateVersion = "23.11";
}
