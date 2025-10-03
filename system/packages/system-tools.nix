{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # System Tools
    bash
    gnome-tweaks
    wmctrl
    zenity
    zip
    p7zip
    killall
    lm_sensors
    jq
    bibata-cursors
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin

    ffmpeg-full
    ocamlPackages.gstreamer
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    pkgs.xorg.libXxf86vm
    pkgs.xorg.libX11
    pkgs.openal
    pkgs.alsa-lib
    pkgs.libpulseaudio

    webkitgtk_4_1

    # Hardware Support
    linuxKernel.packages.linux_zen.xpadneo
    bluetuith
    blueberry
    jstest-gtk
    evtest
    corectrl
    protontricks

    # Performance & System Tweaks
    ananicy
    irqbalance
    preload
  ];
}