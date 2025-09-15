{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Media & Communication
    audacity
    
    # Custom packages
    (pkgs.callPackage ../../lib/custom-packages/warp-terminal/package.nix {})
  ];
}