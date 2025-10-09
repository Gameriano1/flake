{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Development Tools
    appimage-run
    git
    jdk8  # Java 21 LTS
    
    # Java Development Tools
    devenv
    appimage-run
    gdb
    gobject-introspection
    gtk3-x11
    gsettings-desktop-schemas
    pkg-config

    (callPackage /home/leleodocapa/Documents/Projetos/shotgun_interactive/shotgun.nix { })
  ];
}