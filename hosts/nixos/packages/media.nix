{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Media & Communication
    audacity
  ];
}