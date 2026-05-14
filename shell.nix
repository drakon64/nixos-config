let
  pkgs = import (import ./lon.nix).nixpkgs { };
in
pkgs.mkShellNoCC {
  packages = with pkgs; [
    colmena
    lon
    nixfmt
    opentofu
    zstd
  ];

  passthru.opentofu = pkgs.mkShellNoCC {
    packages = [ pkgs.opentofu ];
  };
}
