{ pkgs, ... }: {
  home.packages = with pkgs; [
    # System Tools
    nh
    micro
    p7zip-rar
    home-manager
    wget
    nil
    nixd
    remmina
    flameshot
    eza  # Modern replacement for ls
    
    # Fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    btop
    
    # Migrated from host
    gnome-tweaks
    zenity
    zip
    p7zip
    jq
    bibata-cursors
    
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    
    evtest
    jstest-gtk
    bluetuith
    blueberry
  ];
}