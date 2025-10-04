{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Media & Applications
    kitty
    vlc
    vivaldi
    google-chrome
    kdePackages.kdenlive
    obsidian
    discord
  ];
}