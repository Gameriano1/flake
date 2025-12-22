{
  # Configurações para Google Chrome e navegadores baseados em Chromium
  # Desabilita AGC (Automatic Gain Control) e processamento de áudio
  
  programs.chromium = {
    enable = false; # Não instala chromium, apenas configura
    commandLineArgs = [
      # Desabilita AGC e processamento de áudio automático
      "--disable-features=AudioServiceAudioStreams"
      "--disable-features=AudioServiceOutOfProcess"
      "--disable-audio-processing"
      
      # Desabilita controle automático de ganho (AGC)
      "--aec-refinement-off"
      "--disable-webrtc-hw-encoding"
      "--disable-webrtc-hw-decoding"
      
      # Força uso direto do PipeWire sem processamento
      "--enable-features=WebRTCPipeWireCapturer"
      "--disable-features=WebRtcAllowInputVolumeAdjustment"
      
      # Flags adicionais para controle de áudio
      "--autoplay-policy=no-user-gesture-required"
    ];
  };
  
  # Configuração via ambiente para Google Chrome
  home.sessionVariables = {
    # Desabilita AGC no Chrome via variável de ambiente
    CHROME_FLAGS = "--disable-features=WebRtcAllowInputVolumeAdjustment --disable-audio-processing";
  };
  
  # Criar arquivo de configuração para Google Chrome
  home.file.".config/chrome-flags.conf".text = ''
    --disable-features=WebRtcAllowInputVolumeAdjustment
    --disable-audio-processing
    --aec-refinement-off
    --enable-features=WebRTCPipeWireCapturer
  '';
  
  # Criar arquivo de configuração para Vivaldi
  home.file.".config/vivaldi-flags.conf".text = ''
    --disable-features=WebRtcAllowInputVolumeAdjustment
    --disable-audio-processing
    --aec-refinement-off
    --enable-features=WebRTCPipeWireCapturer
  '';
}
