{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    lix-module = {
          url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";
          inputs.nixpkgs.follows = "nixpkgs";
        };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      lix-module,
    }:
    {
      nixosConfigurations = rec {
        netboot = nixpkgs.lib.nixosSystem {
          modules = [
          lix-module.nixosModules.default
          ./netboot.nix
          ];
        };

        pi =
          let
            ipxe =
              let
                pkgs = nixpkgs.legacyPackages.x86_64-linux;
              in
              pkgs.ipxe.override {
                embedScript = pkgs.writeText "embed" ''
                  #!ipxe

                  dhcp
                  chain http://192.168.2.2/netboot.ipxe
                '';
              };
          in
          nixpkgs.lib.nixosSystem {
            modules = [
              lix-module.nixosModules.default
              ./configuration.nix
              nixos-hardware.nixosModules.raspberry-pi-4
            ];

            specialArgs = {
              inherit ipxe netboot;
            };
          };
      };
    };
}
