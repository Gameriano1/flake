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
  };
}
