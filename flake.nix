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

    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    preload-ng = {
      url = "github:miguel-b-p/preload-ng";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flox = {
      url = "github:flox/flox/latest";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, chaotic, home-manager, antigravity-nix, preload-ng, flox, ... }@inputs: {
    
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
          ./hosts/nixos
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager

          preload-ng.nixosModules.default
          {
            services.preload-ng.enable = true;
          }
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.leleodocapa = import ./users/leleodocapa;
            home-manager.extraSpecialArgs = { inherit inputs; homeStateVersion = "25.05"; };
            environment.systemPackages = [
              antigravity-nix.packages.x86_64-linux.default
              flox.packages.x86_64-linux.default
            ];
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
        modules = [ ./users/leleodocapa ];
      };
    };



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
            pkgs.home-manager
          ];
          shellHook = ''
            echo "🔧 NixOS Configuration Development Environment"

          '';
        };
      };
  };
}