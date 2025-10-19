{
  programs.starship = {
    enable = true;
    enableZshIntegration = false;  # Using custom Agnoster theme for ZSH
    enableBashIntegration = true;  # Enable for Bash and nix-shell
    
    settings = {
      # Red theme configuration matching Agnoster
      format = "$username$hostname$directory$git_branch$git_status$nix_shell$character";
      add_newline = true;
      
      # Character (prompt symbol)
      character = {
        success_symbol = "[❯](bold red)";
        error_symbol = "[❯](bold bright-red)";
        vicmd_symbol = "[❮](bold red)";
      };
      
      # Username
      username = {
        show_always = false;
        style_user = "bold bright-red";
        style_root = "bold bright-red";
        format = "[$user]($style)";
      };
      
      # Hostname
      hostname = {
        ssh_only = true;
        style = "bold bright-red bg:red";
        format = "[@$hostname]($style) ";
      };
      
      # Directory - the focal point
      directory = {
        style = "bold white bg:red";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        truncate_to_repo = true;
        read_only = " 🔒";
      };
      
      # Git branch
      git_branch = {
        symbol = " ";
        style = "bold white bg:124";  # Medium red
        format = "[ $symbol$branch ]($style)";
      };
      
      # Git status
      git_status = {
        style = "bold white bg:196";  # Crimson when dirty
        format = "([$all_status$ahead_behind]($style) )";
        conflicted = "⚔️";
        ahead = "↑$count";
        behind = "↓$count";
        diverged = "↕$count";
        untracked = "?$count";
        stashed = "⚑$count";
        modified = "±$count";
        staged = "+$count";
        renamed = "»$count";
        deleted = "✘$count";
      };
      
      # Nix-shell indicator
      nix_shell = {
        symbol = "❄️ ";
        style = "bold white bg:52";  # Dark red
        format = "[ $symbol$name ]($style)";
        impure_msg = "";
        pure_msg = "";
      };
      
      # Additional modules with red theme
      python = {
        symbol = "🐍 ";
        style = "bold red";
        format = "[$symbol$version]($style) ";
      };
      
      nodejs = {
        symbol = " ";
        style = "bold red";
        format = "[$symbol$version]($style) ";
      };
      
      rust = {
        symbol = "🦀 ";
        style = "bold red";
        format = "[$symbol$version]($style) ";
      };
      
      golang = {
        symbol = "🐹 ";
        style = "bold red";
        format = "[$symbol$version]($style) ";
      };
      
      # Time (optional)
      time = {
        disabled = true;
        style = "bold white";
        format = "[$time]($style) ";
      };
    };
  };
}