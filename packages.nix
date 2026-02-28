{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    atuin
    bat
    btop
    cifs-utils
    clinfo
    curl
    file
    git
    git-credential-manager
    less
    lsd
    nfs-utils
    wget
    zoxide
    zsh
  ];
  programs.nix-ld.enable = true;
}
