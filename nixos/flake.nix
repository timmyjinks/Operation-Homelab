{
  description = "Operation Homelab NixOS hosts";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... }@inputs:
    let
      mkHost = hostname: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          disko.nixosModules.disko
          ./modules/common
          ./hosts/${hostname}
          { networking.hostName = hostname; }
        ];
      };
    in
    {
      nixosConfigurations = nixpkgs.lib.genAttrs [
        "home-server-0"
        "home-tysoncloud-0"
        "ovh-server-0"
      ] mkHost;
    };
}
