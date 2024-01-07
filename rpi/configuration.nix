{ config, inputs, lib, pkgs, ... }:

let
  sys = inputs.nixos.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      ({ config, pkgs, ... }: {
        imports = [
          <nixpkgs/nixos/modules/installer/netboot/netboot-minimal.nix>
        ];

        system.stateVersion = "23.11";
      })
    ];
  };

  netboot = sys.config.system.build;
in {
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
  ];

  boot = {
    binfmt.emulatedSystems = [ "x86_64-linux" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  services.pixiecore = {
    enable = true;

    dhcpNoBind = true;
    mode = "boot";
    openFirewall = true;

    kernel = "${netboot.kernel}/bzImage";
    initrd = "${netboot.netbootRamdisk}/initrd";
  };

  networking = {
    defaultGateway = {
      address = "192.168.1.1";
      interface = "eth0";
    };

    interfaces.eth0.ipv4.addresses = [{
      address = "192.168.1.2";
      prefixLength = 24;
    }];

    nameservers = [ "192.168.1.1" ];
  };

  nixpkgs.overlays = [(final: super: {
    zfs = super.zfs.overrideAttrs(_: {
      meta.platforms = [];
    });
  })];

  system.stateVersion = "23.11";

  users.users."nixos" = {
    extraGroups = [ "wheel" ];
    initialPassword = "nixos";
    isNormalUser = true;
    name = "NixOS";
    shell = pkgs.bashInteractive;
  };
}
