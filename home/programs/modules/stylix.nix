{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.homeModules.stylix ];

  home.packages = with pkgs; [
    dejavu_fonts
    jetbrains-mono
    noto-fonts
    noto-fonts-lgc-plus
    texlivePackages.hebrew-fonts
    noto-fonts-color-emoji
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts.symbols-only

    # WhiteSur packages corretos
    whitesur-gtk-theme
    whitesur-cursors
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

    targets = {
      neovim.enable = false;
      waybar.enable = false;
      wofi.enable = true;
      hyprland.enable = true;
      hyprlock.enable = true;
      gnome.enable = false;
    };

    cursor = {
      # forçando o nome do tema de cursor para evitar conflito com defaults
      name = "WhiteSur-cursors";
      size = 24;
      package = pkgs.whitesur-cursors;
    };

    fonts = { emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
      monospace = {
        name = "JetBrains Mono";
        package = pkgs.jetbrains-mono;
      };
      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };

      sizes = {
        terminal = 13;
        applications = 11;
      }; 
      }; # mantive seu bloco de fonts como estava
    iconTheme = {
      enable = true;
      package = pkgs.whitesur-icon-theme.override {
        alternativeIcons = true;
      };
      dark = "WhiteSur-dark";
      light = "WhiteSur-light";
    };

    image = pkgs.fetchurl {
      url = "https://codeberg.org/lunik1/nixos-logo-gruvbox-wallpaper/raw/branch/master/png/gruvbox-dark-rainbow.png";
      sha256 = "036gqhbf6s5ddgvfbgn6iqbzgizssyf7820m5815b2gd748jw8zc";
    };
  };
}
