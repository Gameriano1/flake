{ ... }: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    
    # Shell aliases - same as ZSH
    shellAliases = {
      # Eza (modern ls replacement) with red theme
      ls = "eza --icons --group-directories-first";
      ll = "eza --icons --long --group-directories-first --header";
      la = "eza --icons --long --all --group-directories-first --header";
      lt = "eza --icons --tree --level=2 --group-directories-first";
      lta = "eza --icons --tree --level=2 --all --group-directories-first";
      ltree = "eza --icons --tree --group-directories-first";
      l = "eza --icons --long --all --group-directories-first --header --git";
      
      # Git shortcuts
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      
      # Navigation
      ".." = "cd ..";
    };
    
    # Custom bash configuration with red theme
    bashrcExtra = ''
      # Simple red-themed prompt for nix-shell
      RED='\[\033[0;31m\]'
      BOLD_RED='\[\033[1;31m\]'
      GRAY='\[\033[0;90m\]'
      RESET='\[\033[0m\]'
      
      # Git branch function
      parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
      }
      
      # Simple prompt with red theme
      if [ -n "$IN_NIX_SHELL" ]; then
        PS1="$BOLD_RED[nix-shell]$RESET $RED\u@\h$RESET:$GRAY\w$RESET$BOLD_RED\$(parse_git_branch)$RESET\n$BOLD_RED❯$RESET "
      else
        PS1="$RED\u@\h$RESET:$GRAY\w$RESET$BOLD_RED\$(parse_git_branch)$RESET\n$BOLD_RED❯$RESET "
      fi
      
      # Enable better history
      shopt -s histappend
      shopt -s checkwinsize
      HISTCONTROL=ignoreboth
      HISTSIZE=10000
      HISTFILESIZE=20000
      
      # Better tab completion
      bind "set completion-ignore-case on"
      bind "set show-all-if-ambiguous on"
      
      # Eza colors (red theme)
      export EZA_COLORS="di=31:ex=91:*.nix=91:*.sh=31:*.py=91"
      
      # Enable zoxide if available
      if command -v zoxide &> /dev/null; then
        eval "$(zoxide init bash)"
      fi
    '';
  };
}
