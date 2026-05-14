{
  config,
  lib,
  pkgs,
  ...
}:

{
  hardware.raspberry-pi.configtxt.settings.all.arm_boost = false;

  security.sudo.wheelNeedsPassword = false;
}
