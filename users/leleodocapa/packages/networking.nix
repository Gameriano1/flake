{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Network Tools
    tailscale
  ];
}