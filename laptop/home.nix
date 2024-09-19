{ pkgs, ... }:

let
  cosmic-wallpapers = pkgs.fetchzip {
    url = "https://github.com/pop-os/cosmic-wallpapers/archive/0f2f16dc39ff1281a56680e37719e98a1bc8cb99.zip";
    sha256 = "B8pO5Qjnv03yJumwLsvQ4SeQGcm110PPCgNO3oXUC64=";
    stripRoot = false;
  };
in
{
  home = {
    homeDirectory = "/home/adamc";
    stateVersion = "24.05";
    username = "adamc";

    file = {
      "Pictures/Wallpapers/A_stormy_stellar_nursery_esa_379309.jpg".source = "${cosmic-wallpapers}/original/A_stormy_stellar_nursery_esa_379309.jpg";
      "Pictures/Wallpapers/orion_nebula_nasa_heic0601a.jpg".source = "${cosmic-wallpapers}/original/orion_nebula_nasa_heic0601a.jpg";
      "Pictures/Wallpapers/otherworldly_earth_nasa_ISS064-E-29444.jpg".source = "${cosmic-wallpapers}/original/otherworldly_earth_nasa_ISS064-E-29444.jpg";
      "Pictures/Wallpapers/tarantula_nebula_nasa_PIA23646.jpg".source = "${cosmic-wallpapers}/original/tarantula_nebula_nasa_PIA23646.jpg";
    };
  };
}
