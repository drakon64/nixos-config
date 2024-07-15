{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    nixos-cosmic = {
      url = "github:drakon64/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-cosmic }: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        modules = [
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" "https://drakon64-nixos-cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" "drakon64-nixos-cosmic.cachix.org-1:bW2gsh5pbdMxcI3sklvtROM9A8CXtPXgVwmIcO3E3io=" ];
            };
          }
          nixos-cosmic.nixosModules.default
          ./configuration.nix
        ];
      };
    };
  };
}
