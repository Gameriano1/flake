{
  environment.sessionVariables = rec {
    TERMINAL = "warp-terminal";
    EDITOR = "micro";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };
}