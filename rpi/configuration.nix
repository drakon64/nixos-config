{ config, inputs, pkgs, ... }:

let
  netboot = inputs.nixos.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      ({ config, pkgs, ... }: {
        imports = [
          <nixpkgs/nixos/modules/installer/netboot/netboot-minimal.nix>
        ];

        system.stateVersion = "23.11";
      })
    ];
  }.config.system.build;
in {
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
  ];

  boot = {
    binfmt.emulatedSystems = [ "x86_64-linux" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

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
      dhcp-boot = [ "tag:!iPXE,snponly.efi,192.168.1.2" "tag:iPXE,http://192.168.1.2/boot.ipxe" ];

      interface = "bind-dynamic";
      port = 0;
    };
  };

  nixpkgs.overlays = [(final: super: {
    zfs = super.zfs.overrideAttrs(_: {
      meta.platforms = [];
    });
  })];

  system.stateVersion = "23.11";
}
