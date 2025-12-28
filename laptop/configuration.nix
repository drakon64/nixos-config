{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nix-darwin>
    ./home.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      cachix
      ffmpeg
      gh
      google-cloud-sdk
      lon
      nixfmt-rfc-style
      opentofu
      watch
      x264
      yt-dlp
    ];

    variables = {
      EDITOR = "vim";
    };
  };

  nix = {
    buildMachines = [
      {
        hostName = "eu.nixbuild.net";
        system = "x86_64-linux";
        maxJobs = 100;
        supportedFeatures = [
          "benchmark"
          "big-parallel"
          "kvm"
        ];
      }

      {
        hostName = "eu.nixbuild.net";
        system = "i686-linux";
        maxJobs = 100;
        supportedFeatures = [
          "benchmark"
          "big-parallel"
        ];
      }

      {
        hostName = "eu.nixbuild.net";
        system = "aarch64-linux";
        maxJobs = 100;
        supportedFeatures = [
          "benchmark"
          "big-parallel"
          "kvm"
        ];
      }

      {
        hostName = "eu.nixbuild.net";
        system = "armv7l-linux";
        maxJobs = 100;
        supportedFeatures = [
          "benchmark"
          "big-parallel"
        ];
      }
    ];

    distributedBuilds = true;
    optimise.automatic = true;
    package = pkgs.lixPackageSets.stable.lix;

    settings = {
      extra-experimental-features = [ "nix-command" ];
      substituters = [ "https://drakon64.cachix.org" ];
      trusted-public-keys = [ "drakon64.cachix.org-1:CC++mZuiGA9YysXP7W0pAoftcx+zyPslUjGPQTnMazg=" ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      (final: prev: {
        inherit (prev.lixPackageSets.stable)
          nixpkgs-review
          nix-eval-jobs
          nix-fast-build
          colmena
          ;
      })
    ];
  };

  programs = {
    direnv.enable = true;
    fish.enable = true;

    ssh = {
      extraConfig = ''
        Host eu.nixbuild.net
          PubkeyAcceptedKeyTypes ssh-ed25519
          ServerAliveInterval 60
          IPQoS throughput
          IdentityFile /var/root/.ssh/nixbuild
      '';

      knownHosts = {
        nixbuild = {
          hostNames = [ "eu.nixbuild.net" ];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
        };
      };
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  users = {
    knownUsers = [ "evelynchance" ];

    users.evelynchance = {
      home = "/Users/evelynchance";
      name = "evelynchance";
      shell = pkgs.fish;
      uid = 501;
    };
  };
}
