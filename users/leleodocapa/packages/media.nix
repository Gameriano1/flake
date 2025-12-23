{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Media & Applications
    vlc
    vivaldi
    google-chrome
    kdePackages.kdenlive
    vesktop
    spotify
    wike
  ];
}