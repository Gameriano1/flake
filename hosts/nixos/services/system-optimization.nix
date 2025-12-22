{ pkgs, ... }: {
  services = {
    ananicy = {
      enable = true;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };
    irqbalance.enable = true;
  };
}