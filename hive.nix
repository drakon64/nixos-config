let
  pkgs = import (import ./lon.nix).nixpkgs { };
in
{
  meta.nixpkgs = pkgs;

  pi =
    { pkgs, ... }:

    {
      deployment = {
        buildOnTarget = true;
        targetHost = "pi";
        targetUser = "evelyn";
      };

      imports = [ ./pi/configuration.nix ];

      nixpkgs.system = "aarch64-linux";
    };
}
