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
    }:
    {
      nixosConfigurations.pi = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          nixos-hardware.nixosModules.raspberry-pi-3
        ];
      };

      packages.aarch64-linux.sdImage =
        let
          system = "aarch64-linux";

          nixosConfig = nixpkgs.lib.nixosSystem {
            modules = [
              (
                {
                  pkgs,
                  modulesPath,
                  ...
                }:
                {
                  imports = [
                    ./configuration.nix
                    nixos-hardware.nixosModules.raspberry-pi-3
                    "${builtins.toString modulesPath}/installer/sd-card/sd-image-aarch64.nix"
                  ];
                }
              )
            ];
          };
        in
        nixosConfig.config.system.build.sdImage
        // {
          closure = nixosConfig.config.system.build.sdImage;
          inherit (nixosConfig) config pkgs;
        };
    };
}
