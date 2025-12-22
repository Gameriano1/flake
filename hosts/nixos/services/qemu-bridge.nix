{
  pkgs,
  ...
}: {
  # Configuração de bridge isolada para QEMU
  # Cria uma rede virtual separada que não interfere na rede principal
  
  # Não duplicar configuração do libvirtd (já está no cockpit)
  # Apenas configurar bridge helper

  # Configurar bridge helper para QEMU
  environment.etc."qemu/bridge.conf".text = ''
    allow qemubr0
  '';

  # Script para criar bridge isolada
  systemd.services.qemu-bridge-setup = {
    description = "Setup QEMU Bridge Network";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    
    script = ''
      # Criar bridge qemubr0 se não existir
      if ! ${pkgs.iproute2}/bin/ip link show qemubr0 &>/dev/null; then
        ${pkgs.iproute2}/bin/ip link add name qemubr0 type bridge
        ${pkgs.iproute2}/bin/ip addr add 192.168.100.1/24 dev qemubr0
        ${pkgs.iproute2}/bin/ip link set qemubr0 up
      fi
      
      # Configurar NAT para VMs acessarem internet
      ${pkgs.iptables}/bin/iptables -t nat -C POSTROUTING -s 192.168.100.0/24 ! -d 192.168.100.0/24 -j MASQUERADE 2>/dev/null || \
      ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 192.168.100.0/24 ! -d 192.168.100.0/24 -j MASQUERADE
      
      # Permitir forward entre bridge e interfaces
      ${pkgs.iptables}/bin/iptables -C FORWARD -i qemubr0 -o qemubr0 -j ACCEPT 2>/dev/null || \
      ${pkgs.iptables}/bin/iptables -A FORWARD -i qemubr0 -o qemubr0 -j ACCEPT
      
      ${pkgs.iptables}/bin/iptables -C FORWARD -i qemubr0 -j ACCEPT 2>/dev/null || \
      ${pkgs.iptables}/bin/iptables -A FORWARD -i qemubr0 -j ACCEPT
      
      ${pkgs.iptables}/bin/iptables -C FORWARD -o qemubr0 -j ACCEPT 2>/dev/null || \
      ${pkgs.iptables}/bin/iptables -A FORWARD -o qemubr0 -j ACCEPT
    '';
    
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  # Servidor DHCP para a bridge isolada
  services.dnsmasq = {
    enable = true;
    settings = {
      # Interface apenas para bridge QEMU
      interface = "qemubr0";
      bind-interfaces = true;
      
      # Range DHCP para VMs
      dhcp-range = "192.168.100.50,192.168.100.150,24h";
      dhcp-option = [
        "3,192.168.100.1"  # Gateway
        "6,8.8.8.8,8.8.4.4"  # DNS
      ];
      
      # Evitar conflito com rede principal
      except-interface = "enp6s0";
    };
  };

  # Habilitar IP forwarding
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  # Pacotes adicionais para bridge
  environment.systemPackages = with pkgs; [
    bridge-utils
    iptables
  ];

  # Firewall: permitir tráfego na bridge
  networking.firewall = {
    trustedInterfaces = [ "qemubr0" ];
    allowedTCPPorts = [ 67 ]; # DHCP
    allowedUDPPorts = [ 67 53 ]; # DHCP e DNS
  };
}