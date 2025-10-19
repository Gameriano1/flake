{ config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Autosuggestion com estilo customizado
    autosuggestion.strategy = [ "history" "completion" ];

    # Syntax highlighting com cores personalizadas
    syntaxHighlighting.highlighters = [ "main" "brackets" "pattern" "cursor" ];
    
    localVariables = {
      PATH="$PATH:/home/leleodocapa/go/bin:/home/leleodocapa/.local/bin";
      
      # Cores customizadas para zsh-autosuggestions
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666,bg=bold,underline";
    };
    
    shellAliases = {
        sw = "nh os switch";
        upd = "nh os switch --update";
        bf = "bash /home/leleodocapa/Documents/bf.sh";
        bfb = "bash /home/leleodocapa/Documents/bfb.sh";

        #rovodev = "acli rovodev";
        #acli = "~/rovodev/acli";

        kali = "distrobox enter --root kali";
        k = "distrobox enter --root kali --";

        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gl = "git log --oneline --graph --decorate --all";
        gd = "git diff";

        shotgun = "steam-run /home/leleodocapa/Documents/Projetos/shotgun_interactive/dist/shotgun/shotgun";

        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        
        # Aliases com cores
        ls = "ls --color=auto";
        ll = "ls -lah --color=auto";
        la = "ls -A --color=auto";
        grep = "grep --color=auto";
        
        # Atalhos úteis
        c = "clear";
        h = "history";
        q = "exit";
      };

    initExtra = ''
      # Zoxide
      eval "$(zoxide init zsh)"
      
      # Configurações de cores para o terminal
      export LS_COLORS="di=1;31:fi=0;37:ln=1;35:pi=40;33:so=1;35:bd=40;33;1:cd=40;33;1:or=40;31;1:ex=1;32:*.tar=1;31:*.tgz=1;31:*.zip=1;31:*.z=1;31:*.gz=1;31:*.bz2=1;31"
      
      # Configurações de estilo para syntax highlighting
      ZSH_HIGHLIGHT_STYLES[command]='fg=red,bold'
      ZSH_HIGHLIGHT_STYLES[alias]='fg=red,bold'
      ZSH_HIGHLIGHT_STYLES[builtin]='fg=red,bold'
      ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
      ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=purple'
      ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'
      ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=white,bold'
      ZSH_HIGHLIGHT_STYLES[arg0]='fg=red'
      ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
      ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
      
      # Mensagem de boas-vindas estilosa
      echo ""
      echo -e "\033[1;31m╔═══════════════════════════════════════╗\033[0m"
      echo -e "\033[1;31m║\033[1;37m     🚀 Welcome to the Terminal! 🚀   \033[1;31m║\033[0m"
      echo -e "\033[1;31m╚═══════════════════════════════════════╝\033[0m"
      echo ""
      
      # Keybindings úteis
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward
      bindkey '^[[H' beginning-of-line
      bindkey '^[[F' end-of-line
      bindkey '^[[3~' delete-char
    '';
    
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
    history.ignoreDups = true;
    history.ignoreSpace = true;
    history.share = true;
  };
}