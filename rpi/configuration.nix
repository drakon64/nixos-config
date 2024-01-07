{ config, inputs, lib, pkgs, ... }:

let
  sys = inputs.nixos.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ({ config, pkgs, lib, modulesPath, ... }: {
        imports = [ (modulesPath + "/installer/netboot/netboot-minimal.nix") ];
      })
    ];
  };

  build = sys.config.system.build;
in {
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];

  services.pixiecore = {
    enable = true;
    openFirewall = true;
    dhcpNoBind = true;

    mode = "boot";
    kernel = "${build.kernel}/bzImage";
    initrd = "${build.netbootRamdisk}/initrd";
  };
}
