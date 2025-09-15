{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Security & Networking
    cloudflare-warp
    
    # Custom security packages
    (pkgs.callPackage ../../lib/custom-packages/burp/package.nix {})
  ];

}