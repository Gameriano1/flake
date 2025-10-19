{ ... }: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    
    # Environment variables
    sessionVariables = {
      # Eza colors - same as ZSH
      EZA_COLORS = "da=38;5;250:sn=38;5;250:sb=38;5;250:uu=38;5;196:un=38;5;196:gu=38;5;124:gn=38;5;124:ur=38;5;160:uw=38;5;196:ux=38;5;124:ue=38;5;124:gr=38;5;240:gw=38;5;240:gx=38;5;240:tr=38;5;235:tw=38;5;235:tx=38;5;235:di=38;5;160;1:ex=38;5;196;1:fi=38;5;250:ln=38;5;124:or=38;5;196;48;5;234:*.md=38;5;15:*.txt=38;5;250:*.nix=38;5;160:*.sh=38;5;124:*.py=38;5;196:*.rs=38;5;160:*.go=38;5;124:*.js=38;5;196:*.ts=38;5;160:*.json=38;5;240:*.yaml=38;5;240:*.toml=38;5;240:*.lock=38;5;235:*.log=38;5;235:*.git=38;5;235";
    };
    
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
    
    # Custom bash configuration with Agnoster-like theme
    initExtra = ''
      # Powerline symbols
      SEGMENT_SEPARATOR=$'\ue0b0'
      PLUSMINUS=$'\u00b1'
      BRANCH=$'\ue0a0'
      DETACHED=$'\u27a6'
      CROSS=$'\u2718'
      LIGHTNING=$'\u26a1'
      GEAR=$'\u2699'
      
      # Color definitions using tput
      COLOR_RESET="\[\033[0m\]"
      COLOR_RED_DARK="\[\033[38;5;52m\]"
      COLOR_RED_MEDIUM="\[\033[38;5;124m\]"
      COLOR_RED_BRIGHT="\[\033[38;5;160m\]"
      COLOR_CRIMSON="\[\033[38;5;196m\]"
      COLOR_WHITE="\[\033[38;5;15m\]"
      COLOR_GRAY_LIGHT="\[\033[38;5;250m\]"
      COLOR_GRAY_MEDIUM="\[\033[38;5;240m\]"
      COLOR_GRAY_DARK="\[\033[38;5;235m\]"
      
      # Background colors
      BG_RED_DARK="\[\033[48;5;52m\]"
      BG_RED_MEDIUM="\[\033[48;5;124m\]"
      BG_RED_BRIGHT="\[\033[48;5;160m\]"
      BG_CRIMSON="\[\033[48;5;196m\]"
      BG_GRAY_DARK="\[\033[48;5;235m\]"
      BG_GRAY_MEDIUM="\[\033[48;5;240m\]"
      BG_BLACK="\[\033[48;5;0m\]"
      
      # Bold
      BOLD="\[\033[1m\]"
      
      # Git functions
      parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
      }
      
      is_git_dirty() {
        [[ -n $(git status --porcelain 2> /dev/null) ]]
      }
      
      git_prompt() {
        if git rev-parse --git-dir > /dev/null 2>&1; then
          local branch=$(parse_git_branch)
          if [ -n "$branch" ]; then
            if is_git_dirty; then
              echo -e "$BG_CRIMSON$COLOR_WHITE $BRANCH $branch $PLUSMINUS $COLOR_RESET$COLOR_CRIMSON$SEGMENT_SEPARATOR$COLOR_RESET"
            else
              echo -e "$BG_RED_MEDIUM$COLOR_WHITE $BRANCH $branch $COLOR_RESET$COLOR_RED_MEDIUM$SEGMENT_SEPARATOR$COLOR_RESET"
            fi
          fi
        fi
      }
      
      # Status segment for errors
      status_segment() {
        local last_status=$?
        if [ $last_status -ne 0 ]; then
          echo -e "$BG_GRAY_DARK$COLOR_CRIMSON $CROSS $last_status $COLOR_RESET$COLOR_GRAY_DARK$SEGMENT_SEPARATOR$COLOR_RESET"
        fi
      }
      
      # Build the prompt
      build_prompt() {
        local prompt=""
        
        # Status (if error)
        local status=$(status_segment)
        if [ -n "$status" ]; then
          prompt="$status "
        fi
        
        # Context (user@host) - only in SSH or if not default user
        if [ -n "$SSH_CONNECTION" ]; then
          prompt="$prompt$BG_CRIMSON$COLOR_WHITE \u@\h $COLOR_RESET$COLOR_CRIMSON$SEGMENT_SEPARATOR$COLOR_RESET "
        elif [ "$USER" != "leleodocapa" ]; then
          prompt="$prompt$BG_GRAY_DARK$COLOR_GRAY_LIGHT \u@\h $COLOR_RESET$COLOR_GRAY_DARK$SEGMENT_SEPARATOR$COLOR_RESET "
        fi
        
        # Directory
        prompt="$prompt$BG_RED_BRIGHT$COLOR_WHITE$BOLD \w $COLOR_RESET$COLOR_RED_BRIGHT$SEGMENT_SEPARATOR$COLOR_RESET "
        
        # Git
        local git_info=$(git_prompt)
        if [ -n "$git_info" ]; then
          prompt="$prompt$git_info "
        fi
        
        # Newline and prompt symbol
        prompt="$prompt\n$COLOR_CRIMSON❯$COLOR_RESET "
        
        echo "$prompt"
      }
      
      # Set the prompt
      PROMPT_COMMAND='PS1="$(build_prompt)"'
      
      # Nix-shell detection and indication
      if [ -n "$IN_NIX_SHELL" ]; then
        # Add nix-shell indicator to prompt
        nix_shell_prompt() {
          local shell_name=""
          if [ -n "$name" ]; then
            shell_name=" $name"
          fi
          echo -e "$BG_RED_DARK$COLOR_WHITE ❄$shell_name $COLOR_RESET$COLOR_RED_DARK$SEGMENT_SEPARATOR$COLOR_RESET"
        }
        
        build_prompt_with_nix() {
          local prompt=""
          
          # Nix shell indicator first
          prompt="$(nix_shell_prompt) "
          
          # Status (if error)
          local status=$(status_segment)
          if [ -n "$status" ]; then
            prompt="$prompt$status "
          fi
          
          # Context (user@host) - only in SSH
          if [ -n "$SSH_CONNECTION" ]; then
            prompt="$prompt$BG_CRIMSON$COLOR_WHITE \u@\h $COLOR_RESET$COLOR_CRIMSON$SEGMENT_SEPARATOR$COLOR_RESET "
          fi
          
          # Directory
          prompt="$prompt$BG_RED_BRIGHT$COLOR_WHITE$BOLD \w $COLOR_RESET$COLOR_RED_BRIGHT$SEGMENT_SEPARATOR$COLOR_RESET "
          
          # Git
          local git_info=$(git_prompt)
          if [ -n "$git_info" ]; then
            prompt="$prompt$git_info "
          fi
          
          # Newline and prompt symbol
          prompt="$prompt\n$COLOR_RED_DARK❄$COLOR_RESET$COLOR_CRIMSON❯$COLOR_RESET "
          
          echo "$prompt"
        }
        
        PROMPT_COMMAND='PS1="$(build_prompt_with_nix)"'
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
      bind "set mark-symlinked-directories on"
      
      # Colored GCC warnings and errors
      export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
      
      # Enable zoxide if available
      if command -v zoxide &> /dev/null; then
        eval "$(zoxide init bash)"
      fi
    '';
  };
}
