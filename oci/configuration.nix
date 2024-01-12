{ config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/oci-image.nix>
  ];

  system.stateVersion = "23.11";
}
