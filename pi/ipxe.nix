{
  config,
  lib,
  pkgs,
  ...
}:

let
  #    ipxeScript = pkgs.writeText "boot.ipxe" ''
  #      #!ipxe
  #      kernel http://pi.drakon.local/kernel init=init initrd=initrd ${toString config.boot.kernelParams}
  #      initrd http://pi.drakon.local/initrd
  #      boot
  #    '';

  netboot =
    let
      configEvaled =
        let
          # TODO: Reuse `pkgs` rather than reimporting
          pkgs86 = import (import ../lon.nix).nixpkgs { system = "x86_64-linux"; };
        in
        pkgs86.nixos [ ./netboot.nix ];

      build = configEvaled.config.system.build;
    in
    {
      ramdisk = build.netbootRamdisk + "initrd";
      kernel = build.kernel + configEvaled.pkgs.stdenv.hostPlatform.linux-kernel.target;
    };
in
{
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];

  environment.systemPackages = [
    #    (pkgs.ipxe.override {
    #      embedScript = ipxeScript;
    #    })

    (pkgs.symlinkJoin {
      name = "netboot";

      paths = [
        netboot.kernel
        netboot.ramdisk
      ];
    })
  ];
}
