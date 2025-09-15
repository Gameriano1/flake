{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Gaming Tools
    (pkgs.bottles.override { removeWarningPopup = true; })
  ];
}