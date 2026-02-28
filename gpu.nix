{ config, pkgs, lib, ... }:
{
  hardware.enableRedistributableFirmware = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-gpu-tools
      intel-media-driver
      intel-compute-runtime
      level-zero
      libva-utils
      vpl-gpu-rt
    ];
  };
}
