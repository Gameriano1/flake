{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    sessionVariables = {
      # Use ZSH in nix-shell instead of bash
      NIX_BUILD_SHELL = "zsh";
    };

    localVariables = {
      PATH="$PATH:/home/leleodocapa/go/bin:/home/leleodocapa/.local/bin";
      
      # Eza colors - Red theme matching Agnoster
      # Format: file_type=foreground;background
      EZA_COLORS = builtins.concatStringsSep ":" [
        "da=38;5;250"           # Date (light gray)
        "sn=38;5;250"           # Size numbers (light gray)
        "sb=38;5;250"           # Size unit (light gray)
        "uu=38;5;196"           # User (crimson)
        "un=38;5;196"           # User name (crimson)
        "gu=38;5;124"           # Group (medium red)
        "gn=38;5;124"           # Group name (medium red)
        "ur=38;5;160"           # User read (bright red)
        "uw=38;5;196"           # User write (crimson)
        "ux=38;5;124"           # User execute (medium red)
        "ue=38;5;124"           # User execute file (medium red)
        "gr=38;5;240"           # Group read (gray)
        "gw=38;5;240"           # Group write (gray)
        "gx=38;5;240"           # Group execute (gray)
        "tr=38;5;235"           # Other read (dark gray)
        "tw=38;5;235"           # Other write (dark gray)
        "tx=38;5;235"           # Other execute (dark gray)
        "di=38;5;160;1"         # Directory (bright red, bold)
        "ex=38;5;196;1"         # Executable (crimson, bold)
        "fi=38;5;250"           # Regular file (light gray)
        "ln=38;5;124"           # Symlink (medium red)
        "or=38;5;196;48;5;234"  # Broken symlink (crimson on dark bg)
        "*.md=38;5;15"          # Markdown (white)
        "*.txt=38;5;250"        # Text files (light gray)
        "*.nix=38;5;160"        # Nix files (bright red)
        "*.sh=38;5;124"         # Shell scripts (medium red)
        "*.py=38;5;196"         # Python (crimson)
        "*.rs=38;5;160"         # Rust (bright red)
        "*.go=38;5;124"         # Go (medium red)
        "*.js=38;5;196"         # JavaScript (crimson)
        "*.ts=38;5;160"         # TypeScript (bright red)
        "*.json=38;5;240"       # JSON (gray)
        "*.yaml=38;5;240"       # YAML (gray)
        "*.toml=38;5;240"       # TOML (gray)
        "*.lock=38;5;235"       # Lock files (dark gray)
        "*.log=38;5;235"        # Log files (dark gray)
        "*.git=38;5;235"        # Git files (dark gray)
      ];
    };
    shellAliases =
      let
        flakeDir = "~/flake";
      in {
        sw = "nh os switch";
        upd = "nh os switch --update";
        bf = "bash /home/leleodocapa/Documents/bf.sh";
        bfb = "bash /home/leleodocapa/Documents/bfb.sh";

        #rovodev = "acli rovodev";
        #acli = "~/rovodev/acli";

        kali = "distrobox enter --root kali";
        k = "distrobox enter --root kali --";

        # Eza (modern ls replacement) with red theme
        ls = "eza --icons --group-directories-first";
        ll = "eza --icons --long --group-directories-first --header";
        la = "eza --icons --long --all --group-directories-first --header";
        lt = "eza --icons --tree --level=2 --group-directories-first";
        lta = "eza --icons --tree --level=2 --all --group-directories-first";
        ltree = "eza --icons --tree --group-directories-first";
        l = "eza --icons --long --all --group-directories-first --header --git";

        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";

        shotgun = "steam-run /home/leleodocapa/Documents/Projetos/shotgun_interactive/dist/shotgun/shotgun";

        ".." = "cd ..";
      };

    initExtra = ''
      eval "$(zoxide init zsh)"
      
      # Load custom Agnoster theme (red/black/white)
      source ${./agnoster-custom.zsh}
      
      # Force nix-shell to use ZSH
      nix-shell() {
        command nix-shell "$@" --command zsh
      }
      
      # Also create nix-develop for flakes
      nix-develop() {
        nix develop "$@" --command zsh
      }
      
      # Export NIX_BUILD_SHELL for other tools
      export NIX_BUILD_SHELL="${pkgs.zsh}/bin/zsh"
      
      # Make nix-shell use ZSH properly
      # This ensures that when entering nix-shell, it uses this .zshrc
      if [[ -n "$IN_NIX_SHELL" ]]; then
        # Already in nix-shell, theme is loaded above
        :
      fi
    '';
    
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };
}