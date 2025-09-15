{ homeStateVersion,  ... }: {
  imports = [
    ./packages/development.nix
    ./packages/system.nix
    ./packages/media.nix
    ./packages/gaming.nix
    ./packages/networking.nix
    ./programs/modules/default.nix
  ];

  home = {
    username = "leleodocapa";
    homeDirectory = "/home/leleodocapa";
    stateVersion = homeStateVersion;
  };

  programs.home-manager.enable = true;
}