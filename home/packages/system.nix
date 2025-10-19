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
  ];
}