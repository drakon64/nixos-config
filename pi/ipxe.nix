{
  config,
  lib,
  pkgs,
  ...
}:

let
  # TODO: Reuse `pkgs` rather than reimporting
  pkgs86 = import (import ../lon.nix).nixpkgs { system = "x86_64-linux"; };
in
{
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];

  networking.firewall.allowedUDPPorts = [ 69 ];

  services.atftpd = {
    enable = true;

    root = (
      pkgs.symlinkJoin {
        name = "netboot";

        paths = [ pkgs86.ipxe ];
      }
    );
  };
}
