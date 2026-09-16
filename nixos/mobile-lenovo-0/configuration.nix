{ pkgs, config, ... }:
{
  imports = [
    ./disko-config.nix
    ./laptop.nix
    ./k3s.nix
    ./docker.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mobile-lenovo-0";
  networking.networkmanager.enable = true;


  time.timeZone = "America/Denver";

  users.users.timmy = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$gu4zW.T0lNMbGoEJPmnxZ/$QUr9z7NfC34R49E..bNrx8QbJW1DSPOO.qe2WcFBkr0";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys =
      [ ];
  };

  environment.systemPackages = with pkgs; [ vim ];

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

  # no touchy
  system.stateVersion = "25.05";
}
