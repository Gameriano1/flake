{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix
    ./boot.nix
    ./kernel.nix
  ];
}