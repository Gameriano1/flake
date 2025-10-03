{ config, ... }: {
  # NVIDIA Configuration
  services.xserver.videoDrivers = ["nvidia"];
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
  
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}