{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/disko/single-disk.nix
    ../../modules/laptop.nix
    ../../modules/services/k3s.nix
    ../../modules/services/docker.nix
  ];

  system.stateVersion = "26.05";
}
