{ pkgs, osConfig, ... }:

let
  dxvk-nvapi = pkgs.fetchzip {
    url = "https://github.com/jp7677/dxvk-nvapi/releases/download/v0.7.1/dxvk-nvapi-v0.7.1.tar.gz";
    sha256 = "076sjchv308zc7fv6mrdph2kd8w5nvgrqjc4acmgpwj3s7v85yjv";
    stripRoot = false;
  };

  dlssTweaks = pkgs.fetchzip {
    url = "https://github.com/emoose/DLSSTweaks/files/15013420/DLSSTweaks-0.200.9.0-beta1.zip";
    sha256 = "19w5kjgy5zayp02mz5rv5g91r31ix5rm1m95qwlxfrp9gbag9dh2";
    stripRoot = false;
  };
in
{
  home = {
    homeDirectory = "/home/adamc";
    stateVersion = "24.05";
    username = "adamc";

    # DXVK-NVAPI
    file.".xlcore/wineprefix/drive_c/windows/system32/nvapi64.dll".source = "${dxvk-nvapi}/x64/nvapi64.dll";
    file.".xlcore/wineprefix/drive_c/windows/syswow64/nvapi.dll".source = "${dxvk-nvapi}/x32/nvapi.dll";
    file.".xlcore/ffxiv/game/nvngx.dll".source = "${osConfig.hardware.nvidia.package}/lib/nvidia/wine/nvngx.dll";
    file.".xlcore/ffxiv/game/_nvngx.dll".source = "${osConfig.hardware.nvidia.package}/lib/nvidia/wine/_nvngx.dll";

    # DLSSTweaks
    file.".xlcore/ffxiv/game/winmm.dll".source = "${dlssTweaks}/nvngx.dll";
  };

  programs.home-manager.enable = true;
}
