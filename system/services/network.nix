{ pkgs, ... }: {
  services = {
    logmein-hamachi.enable = true;
    tailscale.enable = true;
    cloudflare-warp.enable = true;
  };

}