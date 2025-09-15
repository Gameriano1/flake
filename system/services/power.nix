{
  powerManagement.cpuFreqGovernor = "ondemand"; # Or "performance", "ondemand", "conservative", etc.
  powerManagement.enable = true; # Enable power management features

  services.displayManager.gdm.autoSuspend = true;
}