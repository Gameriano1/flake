{ pkgs, ... }: {
  # Database Services
  services.mysql = {
    enable = true;
    package = pkgs.mysql84;
  };
}