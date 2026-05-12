let
  pkgs = import (import ./lon.nix).nixpkgs { };
in
{
  netboot =
    let
      configEvaled = pkgs.nixos [ ./netboot/configuration.nix ];
    in
    {
      kernel = configEvaled.config.system.build.kernel;
      initrd = configEvaled.config.system.build.netbootRamdisk;

      ipxe = pkgs.writeText "boot.ipxe" ''
        #!ipxe

        kernel bzImage init=${configEvaled.config.system.build.toplevel}/init initrd=initrd ${toString configEvaled.config.boot.kernelParams}
        initrd initrd
        boot
      '';
    };

  pi = (pkgs.nixos [ ./pi/configuration.nix ]).config.system.build.sdImage;
}
