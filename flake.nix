{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        # Personal configuration
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/default/configuration.nix
            nixos-wsl.nixosModules.default
            home-manager.nixosModules.default
            {
              system.stateVersion = "24.05";
              wsl.enable = true;
            }
          ];
        };

        # Work configuration
        work = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/work/configuration.nix
            nixos-wsl.nixosModules.default
            home-manager.nixosModules.default
            {
              system.stateVersion = "24.05";
              wsl.enable = true;
            }
          ];
        };
      };
    };
}
