{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-xivlauncher-rb = {
      url = "github:drakon64/nixos-xivlauncher-rb";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic = {
      url = "github:drakon64/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixos-xivlauncher-rb,
      nixos-cosmic,
    }:
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          modules = [
            nixos-cosmic.nixosModules.default
            ./configuration.nix
            home-manager.nixosModules.home-manager

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.adamc = import ./home.nix;
            }
          ];

          specialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
