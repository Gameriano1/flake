{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Gaming Tools
    protonup-qt
    wine
    winetricks
    motrix
    
    # Migrated from host
    bottles
    protontricks
  ];
}