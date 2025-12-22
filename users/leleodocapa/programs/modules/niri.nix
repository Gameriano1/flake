{ pkgs, ... }:

{
  xdg.configFile."niri/config.kdl".text = ''
    output "eDP-1" {
      scale 1.0
    }

    input {
      keyboard {
        xkb {
          layout "br"
          options "caps:escape"
        }
      }
      touchpad {
        tap
        dwt
        natural-scroll
      }
    }

    layout {
      gaps 16
      center-focused-column "never"

      preset-column-widths {
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
      }

      default-column-width { proportion 0.5; }

      focus-ring {
        width 4
        active-color "#7fc8ff"
        inactive-color "#505050"
      }
    }

    binds {
      Mod+Shift+Slash { show-hotkey-overlay; }

      Mod+T { spawn "warp-terminal"; }
      Mod+D { spawn "fuzzel"; }
      Mod+Return { spawn "warp-terminal"; }
      Mod+W { close-window; }

      Mod+Left { focus-column-left; }
      Mod+Right { focus-column-right; }
      Mod+Down { focus-window-down; }
      Mod+Up { focus-window-up; }

      Mod+Ctrl+Left { move-column-left; }
      Mod+Ctrl+Right { move-column-right; }

      Mod+Home { focus-column-first; }
      Mod+End { focus-column-last; }

      Mod+Q { quit; }

      Print { screenshot; }
      Ctrl+Print { screenshot-screen; }
      Alt+Print { screenshot-window; }
    }
  '';
}
