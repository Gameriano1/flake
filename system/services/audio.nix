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
      # Configuração específica para HyperX DuoCast
      (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/51-hyperx-duocast.conf" ''
        # Configuração otimizada para HyperX DuoCast
        monitor.alsa.rules = [
          {
            matches = [
              {
                # Match para o HyperX DuoCast
                node.name = "~alsa_input.*"
              }
            ]
            actions = {
              update-props = {
                api.alsa.use-acp = true
                # Formato de alta qualidade
                audio.format = "S24LE"
                audio.rate = 96000
                audio.allowed-rates = [ 48000 96000 ]
                audio.channels = 2
                audio.position = [ FL FR ]
                
                # Desabilita processamento automático que altera volume
                node.pause-on-idle = false
                session.suspend-timeout-seconds = 0
                
                # Desabilita AGC e outros processamentos
                api.alsa.disable-mmap = false
                api.alsa.disable-batch = false
                api.alsa.use-chmap = false
                
                # Configurações de latência
                api.alsa.period-size = 1024
                api.alsa.headroom = 0
                
                # Desabilita volume automático
                channelmix.normalize = false
                channelmix.mix-lfe = false
                audio.adapt.follower = false
              }
            }
          }
        ]
      '')
      
      # Desabilita processamento de áudio que pode alterar volume
      (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/52-disable-dsp.conf" ''
        # Desabilita DSP e filtros que alteram volume
        monitor.alsa.rules = [
          {
            matches = [
              {
                node.name = "~alsa_input.*"
              }
            ]
            actions = {
              update-props = {
                # Desabilita filtros de áudio
                audio.rate = 96000
                resample.quality = 10
                resample.disable = false
                dither.noise = 0
                
                # Desabilita controles automáticos
                node.autoconnect = true
                node.always-process = false
              }
            }
          }
        ]
      '')
    ];
  };
  
  # Desabilita flat-volumes (evita que aplicativos controlem volume mestre)
  hardware.pulseaudio.extraConfig = ''
    flat-volumes = no
  '';
  
  services.pulseaudio.enable = false;
}