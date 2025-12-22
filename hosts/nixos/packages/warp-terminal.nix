{ pkgs, ... }: {
  # Warp Terminal - Modern Rust-based terminal with AI features
  environment.systemPackages = [
    (pkgs.callPackage ./warp-terminal/package.nix {
      waylandSupport = true;  # Enable Wayland support
    })
  ];

  # Allow unfree package (Warp is proprietary)
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "warp-terminal"
  ];
}
