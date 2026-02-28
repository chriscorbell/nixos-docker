{ config, pkgs, ... }:
{
  users.users.chris = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "docker" ];
    packages = with pkgs; [];
  };
  security.sudo.wheelNeedsPassword = false;
}
