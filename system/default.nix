{ pkgs, hostname, stateVersion, ... }: {
  imports = [
    # Hardware
    ./hardware
    
    # System packages and services
    ./packages/development.nix
    ./packages/virtualization.nix
    ./packages/system-tools.nix
    ./packages/media.nix
    ./packages/steam-run.nix
    ./packages/gaming.nix
    ./packages/security.nix
    ./services/virtualization.nix
    # ./services/qemu-bridge.nix
    ./services/nh.nix
    ./services/audio.nix
    ./services/zram.nix
    ./services/power.nix
    ./services/environment.nix
    ./services/network.nix
    ./services/database.nix
    ./services/system-optimization.nix
    ./services/packages.nix
    
    # User configuration
    ./user.nix
  ];

  # Basic system settings
  networking.hostName = hostname;
  system.stateVersion = stateVersion;
  
  # Time & Locale
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Desktop Environment
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  programs.gamemode.enable = true;

  # Java
  programs.java = { 
    enable = true; 
    package = pkgs.openjdk8; 
  };

  # GNOME tweaks
  services.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.wm.preferences]
    button-layout="appmenu:minimize,maximize,close"
  '';

  # Bluetooth fix
  boot.extraModprobeConfig = ''options bluetooth disable_ertm=1'';

  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
  };

  # Nix settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;
}