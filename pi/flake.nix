{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
    }:
    {
      nixosConfigurations = rec {
        pi = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration.nix
            nixos-hardware.nixosModules.raspberry-pi-3
          ];
        };
      };
    };
}
