{ pkgs, ... }: {
  home.packages = [
    (pkgs.callPackage ./warp-terminal/package.nix {
      waylandSupport = true;
    })
  ];


}
