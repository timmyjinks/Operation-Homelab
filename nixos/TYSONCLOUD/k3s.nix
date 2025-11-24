{...}:

{
  networking.firewall.allowedTCPPorts = [
    6443 
  ];
  networking.firewall.allowedUDPPorts = [
    8472 
  ];
  services.k3s = {
    enable = true;
    role = "server";
    clusterInit = true;
  };
  # services.k3s = {
  #     enable = true;
  #     role = "agent"; 
  #     token = "<randomized common secret>";
  #     serverAddr = "https://<ip>:6443";
  #   };
}
