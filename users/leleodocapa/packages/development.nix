{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Development Tools
    appimage-run
    git
    jdk8  # Java 21 LTS

    appimage-run
    gdb
    gobject-introspection
    gtk3-x11
    gsettings-desktop-schemas
    pkg-config
    nodejs
  ];
}