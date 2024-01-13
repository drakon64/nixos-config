{ config, pkgs, ... }:

{
  imports = [
    ./oci/configuration.nix
  ];

  services = {
    grafana.enable = true;
    mimir.enable = true;
  };
}
