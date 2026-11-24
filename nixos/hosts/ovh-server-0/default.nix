{ pkgs, ... }:
{
  imports = [
    ../../modules/disko/single-disk.nix
    ../../modules/services/wireguard.nix
  ];

  environment.systemPackages = with pkgs; [ tmux ];

  system.stateVersion = "26.05";
}
