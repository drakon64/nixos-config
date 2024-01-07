{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
  ];

  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
}
