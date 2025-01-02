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

      # COSMIC wallpapers
      "${wallpapers}/A_stormy_stellar_nursery_esa_379309.jpg".source =
        "${cosmic-wallpapers}/A_stormy_stellar_nursery_esa_379309.jpg";
      "${wallpapers}/orion_nebula_nasa_heic0601a.jpg".source =
        "${cosmic-wallpapers}/orion_nebula_nasa_heic0601a.jpg";
      "${wallpapers}/otherworldly_earth_nasa_ISS064-E-29444.jpg".source =
        "${cosmic-wallpapers}/otherworldly_earth_nasa_ISS064-E-29444.jpg";
      "${wallpapers}/tarantula_nebula_nasa_PIA23646.jpg".source =
        "${cosmic-wallpapers}/tarantula_nebula_nasa_PIA23646.jpg";

      # HP wallpapers
      "${wallpapers}/digital-planet-navy%2Bgold.png".source = pkgs.fetchurl {
        url = "https://media.githubusercontent.com/media/pop-os/hp-wallpapers/c258494a4d72cf1ffbf5a24342f694f25f9f2c45/original/digital-planet-navy%2Bgold.png";
        hash = "sha256-9n4H8u36xWy+sIK4H993sR3ySpRdHJHBDK8NgjWTEKw=";
      };
      "${wallpapers}/particle-field-navy%2Bgold.png".source = pkgs.fetchurl {
        url = "https://media.githubusercontent.com/media/pop-os/hp-wallpapers/c258494a4d72cf1ffbf5a24342f694f25f9f2c45/original/particle-field-navy%2Bgold.png";
        hash = "sha256-XAzXBBh2w3io58chrKF+w06TPI7ydMUnc2quXvOwyAk=";
      };

      # Pop!_OS wallpapers
      "${wallpapers}/ahmadreza-sajadi-10140-edit.jpg".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/pop-os/wallpapers/f7e1954a668cafc07474938a1f48634cca73fc18/original/ahmadreza-sajadi-10140-edit.jpg";
        hash = "sha256-ot8zEJiaebNP/8ACaKHzSkbSvXMh3vG6bq1m2aWK3iY=";
      };
      "${wallpapers}/benjamin-voros-250200.jpg".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/pop-os/wallpapers/e3014e0dad4615ee16b3485ba0697d996bd26017/original/benjamin-voros-250200.jpg";
        hash = "sha256-NyOIbOew2uydxSTTSd59c770mtAPhSoi9+0qnvjtfp8=";
      };
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
