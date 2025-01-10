{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-xivlauncher-rb = {
      url = "github:drakon64/nixos-xivlauncher-rb";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      lix-module,
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
            lix-module.nixosModules.default
            home-manager.nixosModules.home-manager
            nixos-xivlauncher-rb.nixosModules.default

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.adamc = import ./home.nix;
            }
          ];
        };
      };
    };
}
