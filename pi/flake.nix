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
    let
      ipxe =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        pkgs.ipxe.override {
          embedScript = pkgs.writeText "embed" ''
            #!ipxe

            dhcp
          '';
        };
    in
    {
      nixosConfigurations = rec {
        netboot = nixpkgs.lib.nixosSystem {
          modules = [ ./netboot.nix ];
        };

        pi = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration.nix
            nixos-hardware.nixosModules.raspberry-pi-3
          ];

          specialArgs = {
            inherit ipxe netboot;
          };
        };
      };
    };
}
