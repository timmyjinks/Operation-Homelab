{ pkgs, config, ... }:
{
  sops = {
    defaultSopsFile = ../../hosts + "/${config.networking.hostName}/secrets.yaml";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets.timmy-password.neededForUsers = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Denver";

  users.users.timmy = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.timmy-password.path;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys =
      [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBCka19E7nMXA+CaAmPr4oBybqZwc7g4BBNZVRcM3DTL"
      ];
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
    ports = [ 2222 ];
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
}
