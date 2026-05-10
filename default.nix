let
  pkgs = import (import ./lon.nix).nixpkgs { };
in
{
  pi = (pkgs.nixos [ ./pi/configuration.nix ]).config.system.build.sdImage;
}
