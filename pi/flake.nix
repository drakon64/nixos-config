{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      ...
    }:
    rec {
      nixosConfigurations.pi = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          nixos-hardware.nixosModules.raspberry-pi-3
        ];

        system = "aarch64-linux";
      };

      images.pi = nixpkgs.lib.nixosSystem {
        modules = [
          (
            { modulesPath, ... }:
            {
              imports = [
                ./configuration.nix
                nixos-hardware.nixosModules.raspberry-pi-3
                "${builtins.toString modulesPath}/installer/sd-card/sd-image-aarch64.nix"
              ];
            }
          )
        ];

        system = "x86_64-linux";
      };
    };
}
