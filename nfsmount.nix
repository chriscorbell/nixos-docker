{ config, lib, pkgs, ... }:
{
  fileSystems."/tank" = {
    device = "10.0.0.21:/mnt/nvme/sync/tank";
    fsType = "nfs";
    options = [
      "_netdev"
      "nofail"
      "x-systemd.after=network-online.target"
      "x-systemd.requires=network-online.target"
      "nfsvers=4.2"
    ];
  };
}
