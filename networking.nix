{ config, lib, pkgs, ... }:
{
  networking.useDHCP = false;
  networking.interfaces.ens18.ipv4.addresses = [
    { address = "10.0.0.22"; prefixLength = 24; }
  ];
  networking.defaultGateway = {
    address = "10.0.0.1";
    interface = "ens18";
  };
  networking.nameservers = [ "10.0.0.2" ];
  networking.firewall.enable = false;
}
