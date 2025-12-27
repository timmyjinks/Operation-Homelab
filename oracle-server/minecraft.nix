{ pkgs, ... }: {
  services.minecraft-server.enable = true;
  services.minecraft-server.eula = true;

  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true;
    declarative = true;
    whitelist = {
      username1 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
      username2 = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy";
    };
    serverProperties = {
      server-port = 43000;
      difficulty = 3;
      gamemode = 1;
      max-players = 5;
      motd = "NixOS Minecraft server!";
      white-list = true;
      allow-cheats = true;
    };
    jvmOpts = "-Xms2048M -Xmx4096M";
  };
}
