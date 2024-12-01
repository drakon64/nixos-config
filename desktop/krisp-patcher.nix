# https://github.com/sersorrel/sys/blob/7806b21ce74ef7953c3d38edb0116cc9d0851302/hm/discord/default.nix

{ pkgs, ... }:
let
  krisp-patcher = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/sersorrel/sys/7806b21ce74ef7953c3d38edb0116cc9d0851302/hm/discord/krisp-patcher.py";
    hash = "sha256-h8Jjd9ZQBjtO3xbnYuxUsDctGEMFUB5hzR/QOQ71j/E=";
  };
in
pkgs.writers.writePython3Bin "krisp-patcher" {
  libraries = with pkgs.python3Packages; [
    capstone
    pyelftools
  ];

  flakeIgnore = [
    "E501" # line too long (82 > 79 characters)
    "F403" # ‘from module import *’ used; unable to detect undefined names
    "F405" # name may be undefined, or defined from star imports: module
  ];
} (krisp-patcher)
