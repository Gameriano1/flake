{
  description = "Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, chaotic, home-manager, ... }@inputs: {
    
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs; 
          user = "leleodocapa"; 
          hostname = "nixos";
          stateVersion = "25.05";
        };
        modules = [
          ./system
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.leleodocapa = import ./home;
            home-manager.extraSpecialArgs = { inherit inputs; homeStateVersion = "25.05"; };
          }
        ];
      };
    };

    homeConfigurations = {
      "leleodocapa@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { 
          inherit inputs; 
          user = "leleodocapa";
          homeStateVersion = "25.05";
        };
        modules = [ ./home ];
      };
    };

    # Development Templates
    templates = import ./dev-shells/default.nix;

    nix.settings.trusted-users = [ "root" "leleodocapa" ];

    # Development Shells
    devShells.x86_64-linux = 
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixd
            nil  
            nixpkgs-fmt
            nixos-rebuild
            home-manager
          ];
          shellHook = ''
            echo "🔧 NixOS Configuration Development Environment"
            echo "Available templates:"
            echo "  nix flake init -t .#python    # Python development"
            echo "  nix flake init -t .#node      # Node.js development"  
            echo "  nix flake init -t .#rust      # Rust development"
            echo "  nix flake init -t .#go        # Go development"
            echo "  nix flake init -t .#java      # Java development"
            echo "  And many more..."
          '';
        };
      };
  };
}