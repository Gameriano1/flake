{ pkgs, ... }:
{
  security.rtkit.enable = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    
    # Configuração otimizada para HyperX DuoCast (96kHz)
    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          # Taxa de amostragem nativa do DuoCast
          "default.clock.rate" = 96000;
          "default.clock.allowed-rates" = [ 48000 96000 ];
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 256;
          "default.clock.max-quantum" = 2048;
        };
      };
    };
    
    extraConfig.pipewire-pulse = {
      "10-pulse-properties" = {
        "pulse.properties" = {
          "pulse.min.req" = "256/96000";
          "pulse.default.req" = "1024/96000";
          "pulse.max.req" = "2048/96000";
          "pulse.min.quantum" = "256/96000";
          "pulse.max.quantum" = "2048/96000";
        };
        "stream.properties" = {
          "resample.quality" = 10;
          "channelmix.normalize" = false;
          "channelmix.mix-lfe" = false;
        };
      };
    };
    
    wireplumber.configPackages = [
      # DESABILITA COMPLETAMENTE AGC, Echo Cancellation e processamento de voz
      (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/50-disable-all-processing.conf" ''
        # Remove todos os módulos de processamento de áudio
        
        # Desabilita todos os filtros e chains
        wireplumber.profiles = {
          main = {
            monitor.libcamera = disabled
            monitor.v4l2 = disabled
          }
        }
      '')
      
      # Configuração específica para HyperX DuoCast - SEM processamento
      (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/51-hyperx-duocast.conf" ''
        monitor.alsa.rules = [
          {
            matches = [
              {
                node.name = "~alsa_input.*"
              }
            ]
            actions = {
              update-props = {
                api.alsa.use-acp = true
                audio.format = "S24LE"
                audio.rate = 96000
                audio.allowed-rates = [ 48000 96000 ]
                audio.channels = 2
                audio.position = [ FL FR ]
                
                # CRÍTICO: Desabilita TODO processamento automático
                node.pause-on-idle = false
                session.suspend-timeout-seconds = 0
                
                # Desabilita AGC explicitamente
                api.alsa.disable-mmap = false
                api.alsa.disable-batch = false
                api.alsa.use-chmap = false
                api.alsa.period-size = 1024
                api.alsa.headroom = 0
                
                # Desabilita normalização e adaptação de volume
                channelmix.normalize = false
                channelmix.mix-lfe = false
                audio.adapt.follower = false
                
                # Desabilita todos os filtros de processamento de voz
                node.passive = false
                node.driver = false
                node.always-process = false
                
                # Desabilita compressão dinâmica e limitadores
                audio.dsp.filter-chain = false
              }
            }
          }
        ]
        
        # Desabilita TODOS os nós de processamento (echo-cancel, rnnoise, etc)
        monitor.alsa.rules = [
          {
            matches = [
              {
                node.name = "~alsa_input.*"
              }
            ]
            actions = {
              update-props = {
                # Lista explícita de propriedades a desabilitar
                aec.args = ""
                aec.method = ""
                node.filter.graph = ""
                filter.graph = ""
                audio.echo-cancel = false
                audio.noise-reduction = false
                audio.voice-detect = false
              }
            }
          }
        ]
      '')
      
      # Bloqueia completamente módulos de filtro
      (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/52-block-filters.conf" ''
        # Previne carregamento de filtros de processamento
        wireplumber.settings = {
          # Desabilita carregamento automático de filtros
          filter.forward-format = false
          filter.smart-resample = false
        }
        
        # Remove regras de aplicação de filtros
        monitor.alsa.rules = [
          {
            matches = [
              {
                node.name = "~alsa_input.*"
              }
            ]
            actions = {
              update-props = {
                # Zero processamento de sinal
                resample.quality = 10
                resample.disable = false
                dither.noise = 0
                dither.method = "none"
                
                # Sem controle automático
                node.autoconnect = true
                node.target = ""
                node.link-group = ""
              }
            }
          }
        ]
      '')
    ];
  };
  
  # Configurações adicionais do sistema
  environment.etc = {
    # Desabilita módulos PulseAudio de AGC via configuração global
    "pulse/client.conf".text = ''
      autospawn = no
      daemon-binary = /bin/true
      enable-shm = yes
      flat-volumes = no
    '';
  };
  
  services.pulseaudio.enable = false;
}