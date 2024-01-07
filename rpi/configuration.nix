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

  services.pixiecore = {
    enable = true;

    dhcpNoBind = true;
    mode = "boot";
    openFirewall = true;

    kernel = "${netboot.kernel}/bzImage";
    initrd = "${netboot.netbootRamdisk}/initrd";
  };

  nixpkgs.overlays = [(final: super: {
    zfs = super.zfs.overrideAttrs(_: {
      meta.platforms = [];
    });
  })];

  system.stateVersion = "23.11";
}
