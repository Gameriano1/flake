{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.niri.homeModules.niri
  ];

  programs.niri = {
    enable = true;

    settings = {
      outputs = {
        "eDP-1" = {
          scale = 1.0;
        };
      };

      input = {
        keyboard = {
          xkb = {
            layout = "br";
            options = "caps:escape";
          };
        };
        touchpad = {
          tap = true;
          dwt = true;
          natural-scroll = true;
        };
      };

      layout = {
        gaps = 16;
        center-focused-column = "never";

        preset-column-widths = [
          { proportion = 1.0 / 3.0; }
          { proportion = 1.0 / 2.0; }
          { proportion = 2.0 / 3.0; }
        ];

        default-column-width = { proportion = 1.0 / 2.0; };

        focus-ring = {
          enable = true;
          width = 4;
          active.color = "#7fc8ff";
          inactive.color = "#505050";
        };
      };

      spawn-at-startup = [
        # { command = ["waybar"]; }
      ];

      binds = with config.lib.niri.actions; {
        "Mod+Shift+Slash".action = show-hotkey-overlay;

        "Mod+T".action = spawn "warp-terminal";
        "Mod+D".action = spawn "fuzzel";
        "Mod+Return".action = spawn "warp-terminal";
        "Mod+W".action = close-window;

        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Down".action = focus-window-down;
        "Mod+Up".action = focus-window-up;

        "Mod+Ctrl+Left".action = move-column-left;
        "Mod+Ctrl+Right".action = move-column-right;

        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;

        "Mod+Q".action = quit;

        "Print".action = screenshot;
        "Ctrl+Print".action = screenshot-screen;
        "Alt+Print".action = screenshot-window;
      };
    };
  };
}
