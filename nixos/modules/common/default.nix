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
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCjySdMyjMatA9pdrGPgOn9G7D6ijFOZxWF+GYTcJgofTbPbNwPx3CJQ+lhyT6bep8hUAvUowpwSCXXy8jvBRaadPEfaJ30omdOIFjPPlif4dcfURb5Zp2Cvws0UxGPy3fyDgtdur0UGfcyB5+oJ2oaZvxJc4af4EPXtumIIN2r3AUO1tYacRucaFvAH0rPhJ7w7+vD+OMD/OVj36PYNRPvAUdnQRfDedr7uLJTaoZGKNy2RCq+k6td2jh9CC2qCefry/04t31ymvoG9CDP6CEUt6neHkZjFlUWbWH1Ud7FeZZwcK3HsACtQbO6+BoxbHDPYgg2EkGWevYsFQS7HslyWzbv8SPXVMBKfEt7qkUszNY6XQm0yxrlOeZhoubaq2+2QhGF+li6lcxcTU6fITepKfPiXgonje7iQPaLx20CPEJJ7rSQiRcVIWQgdi8fNec/aQuGG6ML+BrKP68h2Fe1/L/MtE6eyjqgvmYYIq0Nxb85Cj8Lio4tshvN4/JGYkk="
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
