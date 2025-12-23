{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # System Tools
    bash
    killall
    lm_sensors
    
    ffmpeg-full
    ocamlPackages.gstreamer
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    pkgs.xorg.libXxf86vm
    pkgs.xorg.libX11
    pkgs.openal
    pkgs.alsa-lib
    pkgs.libpulseaudio
    
    # Audio control tools
    alsa-utils  # amixer, alsamixer
    pulseaudio  # pactl (para PipeWire com compatibilidade PulseAudio)
    pavucontrol # Interface gráfica de controle de áudio
    
    webkitgtk_4_1
    
    # Hardware Support
    linuxKernel.packages.linux_zen.xpadneo
    corectrl
    
    # Performance & System Tweaks

    # Performance & System Tweaks
    ananicy
    irqbalance
  ];
}