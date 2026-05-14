{
  config,
  lib,
  pkgs,
  ...
}:

let
  ipxe =
    let
      # TODO: Reuse `pkgs` rather than reimporting
      pkgs86 = import (import ../lon.nix).nixpkgs { system = "x86_64-linux"; };
    in
    pkgs86.ipxe.override {
      embedScript = (
        pkgs.writeText "autoexec.ipxe" ''
          #!ipxe

          dhcp
          chain https://storage.googleapis.com/pxe.drakon.cloud/chain.ipxe
        ''
      );

      #      enableDefaultPlatformTargets = false;

      additionalTargets = {
        "bin-x86_64-efi/snponly.efi" = "snponly.efi";
      };
    };
in
{
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];

  networking.firewall.allowedUDPPorts = [ 69 ];

  services.atftpd = {
    enable = true;

    root = ipxe;
  };
}
