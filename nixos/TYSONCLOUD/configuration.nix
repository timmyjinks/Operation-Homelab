{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ./fstab-configuration.nix
    ./tailscale.nix
    ./traefik.nix
    ./docker.nix
    # ./laptop.nix
    # ./k3s.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking.hostName = "TYSONCLOUD";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Denver";

  users.users.timmy = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$gu4zW.T0lNMbGoEJPmnxZ/$QUr9z7NfC34R49E..bNrx8QbJW1DSPOO.qe2WcFBkr0";
    extraGroups = [ "wheel" "docker" ];
    openssh.authorizedKeys.keys =
      [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDQQo/lthp8a7idO9NW3VOEM08ORFc46RPDOqNmIFgCe timmy@nobara-pc"
      ];
  };

  users.users.traefik.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [ vim tmux go python3 python3Packages.pip git xfsprogs ];

  services.fail2ban.enable = true;

  services.endlessh = {
    enable = true;
    port = 22;
    openFirewall = true;
  };

  services.openssh = {
    enable = true;
    ports = [ 5432 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "timmy" ];
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
  };

  system.copySystemConfiguration = true;


  system.stateVersion = "25.05";
}
