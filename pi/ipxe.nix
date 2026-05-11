{
  config,
  lib,
  pkgs,
  ...
}:

let
  ipxe = (
    pkgs86.ipxe.override {
      embedScript = (
        pkgs.writeText "boot.ipxe" ''
          #!ipxe

          kernel ${builtins.baseNameOf configEvaled.pkgs.stdenv.hostPlatform.linux-kernel.target} init=${configEvaled.config.system.build.toplevel}/init initrd=initrd ${toString configEvaled.config.boot.kernelParams}
          initrd initrd
          boot
        ''
      );
    }
  );

  # TODO: Reuse `pkgs` rather than reimporting
  pkgs86 = import (import ../lon.nix).nixpkgs { system = "x86_64-linux"; };

  configEvaled = pkgs86.nixos [ ./netboot.nix ];
in
{
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];

  services.atftpd = {
    enable = true;

    root = (
      pkgs.symlinkJoin {
        name = "netboot";

        paths = [
          (ipxe + "/snponly.efi")

          configEvaled.pkgs.stdenv.hostPlatform.linux-kernel.target
          (configEvaled.config.system.build.netbootRamdisk + "/initrd")
        ];
      }
    );
  };
}
