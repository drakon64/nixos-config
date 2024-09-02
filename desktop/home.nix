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
    url = "https://developer.nvidia.com/downloads/assets/gameworks/downloads/secure/dlss/dlss_3_7_10.zip";
    sha256 = "037gza9pwb55xqgq2wnns5kfrki03whiyg7bqxlcnsqbf7grrjmr";
    stripRoot = true;
  };
in
{
  home = {
    homeDirectory = "/home/adamc";
    stateVersion = "24.05";
    username = "adamc";

    file = {
      # DLSSTweaks
      ".xlcore/ffxiv/game/winmm.dll".source = "${dlssTweaks}/nvngx.dll";
      ".xlcore/ffxiv/game/dlsstweaks.ini".source = dlssTweaksIni;

      # DLSS
      ".xlcore/ffxiv/game/nvngx_dlss_new.dll".source = "${dlss}/lib/Windows_x86_64/rel/nvngx_dlss.dll";
    };
  };

  programs.home-manager.enable = true;
}
