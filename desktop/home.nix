{ pkgs, ... }:

let
  dlssTweaks = pkgs.fetchzip {
    url = "https://github.com/emoose/DLSSTweaks/files/15013420/DLSSTweaks-0.200.9.0-beta1.zip";
    sha256 = "19w5kjgy5zayp02mz5rv5g91r31ix5rm1m95qwlxfrp9gbag9dh2";
    stripRoot = false;
  };

  dlssTweaksIni = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/drakon64/DLSSTweaks/25516be262643d74ede0da5794c8687fc1f6546b/dlsstweaks.ini";
    sha256 = "04r04lgkxngdcrvvbcka3pbq82w4q1b09dw6xpdgbg4i46yafmvs";
  };

  dlss = pkgs.fetchzip {
    url = "https://developer.nvidia.com/downloads/assets/gameworks/downloads/secure/dlss/dlss_3.7.20.zip";
    sha256 = "sha256-eTqZRDcm0hLzAaRPu82UkJmCLbev0ZGa8DP3TzCrx2s=";
    stripRoot = true;
  };

  cosmic-wallpapers = "${pkgs.cosmic-wallpapers}/share/backgrounds/cosmic";
  wallpapers = "Pictures/Wallpapers";
in
{
  home = {
    file = {
      # DLSSTweaks
      ".xlcore/ffxiv/game/winmm.dll".source = "${dlssTweaks}/nvngx.dll";
      ".xlcore/ffxiv/game/dlsstweaks.ini".source = dlssTweaksIni;

      # DLSS
      ".xlcore/ffxiv/game/nvngx_dlss_new.dll".source = "${dlss}/lib/Windows_x86_64/rel/nvngx_dlss.dll";

      # Wallpapers
      "${wallpapers}/A_stormy_stellar_nursery_esa_379309.jpg".source =
        "${cosmic-wallpapers}/A_stormy_stellar_nursery_esa_379309.jpg";
      "${wallpapers}/orion_nebula_nasa_heic0601a.jpg".source =
        "${cosmic-wallpapers}/orion_nebula_nasa_heic0601a.jpg";
      "${wallpapers}/otherworldly_earth_nasa_ISS064-E-29444.jpg".source =
        "${cosmic-wallpapers}/otherworldly_earth_nasa_ISS064-E-29444.jpg";
      "${wallpapers}/tarantula_nebula_nasa_PIA23646.jpg".source =
        "${cosmic-wallpapers}/tarantula_nebula_nasa_PIA23646.jpg";
    };

    homeDirectory = "/home/adamc";
    stateVersion = "24.11";
    username = "adamc";
  };

  programs.home-manager.enable = true;

  dconf = {
    enable = true;

    settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };

  programs = {
    git = {
      enable = true;
      userEmail = "6444703+drakon64@users.noreply.github.com";
      userName = "Adam Chance";
    };

    ssh = {
      enable = true;

      #extraConfig = ''
      #  Host *
      #    IdentityAgent ~/.1password/agent.sock
      #'';
    };
  };
}
