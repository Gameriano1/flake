{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Media & Applications
    vlc
    vivaldi
    google-chrome
    kdePackages.kdenlive
    obsidian
    (discord.override {
          withVencord = true;
        })
    spotify
  ];
}