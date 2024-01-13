{ config, pkgs, ... }:

{
  imports = [
    ./oci/configuration.nix
  ];

  services.prometheus.exporters.node = {
    enable = true;
    openFirewall = true;
  };
}
