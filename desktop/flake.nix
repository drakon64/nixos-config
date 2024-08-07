{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-xivlauncher-rb = {
      url = "github:drakon64/nixos-xivlauncher-rb";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-cosmic,
      nixos-xivlauncher-rb,
    }:
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          modules = [
            {
              environment.systemPackages = [
                (nixos-xivlauncher-rb.packages.x86_64-linux.xivlauncher-rb.override { useGameMode = true; })
              ];

              nix.settings = {
                substituters = [
                  "https://cosmic.cachix.org/"
                  "https://drakon64-nixos-cosmic.cachix.org/"
                ];
                trusted-public-keys = [
                  "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
                  "drakon64-nixos-cosmic.cachix.org-1:bW2gsh5pbdMxcI3sklvtROM9A8CXtPXgVwmIcO3E3io="
                ];
              };
            }
            nixos-cosmic.nixosModules.default
            ./configuration.nix
          ];
        };
      };
    };
}
