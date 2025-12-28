{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

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

  home-manager.users.evelynchance =
    { pkgs, ... }:

    {
      programs = {
        fish.enable = true;

        git = {
          enable = true;

          #          signing = {
          #            format = "ssh";
          #            key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII35VQHcwUnBaYdSrNQj+6x5JBVp6cymepWc48V6GnyB";
          #            signByDefault = true;
          #            signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
          #          };

          userEmail = "6444703+drakon64@users.noreply.github.com";
          userName = "Evelyn Chance";
        };

        hyfetch = {
          enable = true;

          settings = {
            preset = "transbian";
            mode = "rgb";
            auto_detect_light_dark = true;
            light_dark = "dark";
            lightness = 0.65;
            color_align.mode = "horizontal";
            backend = "neofetch";
            args = null;
            distro = null;
            pride_month_disable = false;
            custom_ascii_path = null;
          };
        };

        ssh = {
          enable = true;

          extraConfig = ''
            Host *
            	IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
          '';
        };
      };

      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "25.05";
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

    fish = {
      enable = true;

      interactiveShellInit = '''';
    };

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
