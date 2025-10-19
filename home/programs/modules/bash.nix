{ ... }: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historySize = 10000;
    historyFileSize = 20000;
    historyControl = [ "ignoredups" "ignorespace" ];
    
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
    
    # Simple bash config without complex prompts (Starship handles that)
    initExtra = ''
      # Enable case-insensitive completion
      bind "set completion-ignore-case on"
      bind "set show-all-if-ambiguous on"
      
      # Enable zoxide if available
      if command -v zoxide &> /dev/null; then
        eval "$(zoxide init bash)"
      fi
      
      # Eza colors (red theme)
      export EZA_COLORS="da=38;5;250:sn=38;5;250:uu=38;5;196:gu=38;5;124:di=38;5;160:ex=38;5;196:*.nix=38;5;160:*.sh=38;5;124:*.py=38;5;196"
    '';
  };
}
