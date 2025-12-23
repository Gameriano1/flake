{ pkgs, ... }: {
  home.packages = [
    (pkgs.callPackage ./warp-terminal/package.nix {
      waylandSupport = true;
    })
  ];

  # Allow unfree package (Warp is proprietary)
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "warp-terminal"
  ];
}
