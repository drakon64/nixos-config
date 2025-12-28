{ pkgs, ... }:
let
  snackura = pkgs.fetchFromGitHub {
    owner = "SakuSnack";
    repo = "2B-hyfetch-motd";
    rev = "224b58eed82c5e9e37f193ef6977da20167fdd61";
    hash = "sha256-RUKjUehiuhFG6YBPfebq0BVoriLuc+UIjR4dZXau7hg=";
  };
in
{
  home-manager.users.evelynchance = {
    home.file = {
      ".local/bin/thats-so-random.sh" = {
        source = "${snackura}/thats-so-random.sh";
        executable = true;
      };

      ".local/share/thats-so-random/logos" = {
        source = "${snackura}/thats-so-random-logos";
        recursive = true;
      };
    };

    programs = {
      fish = {
        enable = true;

        interactiveShellInit = ''
          .local/bin/thats-so-random.sh
        '';
      };

      git = {
        enable = true;

        #        signing = {
        #          format = "ssh";
        #          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII35VQHcwUnBaYdSrNQj+6x5JBVp6cymepWc48V6GnyB";
        #          signByDefault = true;
        #          signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        #        };

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
}
