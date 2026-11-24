{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/disko/single-disk.nix
  ];

  system.stateVersion = "26.05";
}
