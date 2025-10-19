{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$username$hostname$directory$git_branch$git_status$git_state$character";
      add_newline = true;
      scan_timeout = 10;

      # Username com estilo vermelho
      username = {
        show_always = true;
        format = "[$user]($style)";
        style_user = "bold red";
        style_root = "bold bright-red";
      };

      # Hostname com estilo roxo
      hostname = {
        ssh_only = false;
        format = "[@$hostname]($style) ";
        style = "bold purple";
      };

      # Diretório com estilo branco/vermelho
      directory = {
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "bold white";
        read_only = " 󰌾";
        read_only_style = "red";
        truncation_length = 3;
        truncation_symbol = "…/";
        truncate_to_repo = true;
      };

      # Git branch com estilo verde
      git_branch = {
        format = "[$symbol$branch]($style) ";
        symbol = " ";
        style = "bold green";
      };

      # Git status com cores personalizadas
      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
        style = "bold red";
        conflicted = "🏳";
        ahead = "⇡$count";
        behind = "⇣$count";
        diverged = "⇕⇡$ahead_count⇣$behind_count";
        untracked = "?$count";
        stashed = "📦";
        modified = "!$count";
        staged = "+$count";
        renamed = "»$count";
        deleted = "✘$count";
      };

      # Git state
      git_state = {
        format = "[\\($state( $progress_current/$progress_total)\\)]($style) ";
        style = "bold purple";
      };

      # Character (prompt) com vermelho/verde
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vicmd_symbol = "[❮](bold purple)";
      };

      # Linguagens e ferramentas com cores estilosas
      python = {
        format = "[$symbol$version]($style) ";
        symbol = "🐍 ";
        style = "bold green";
      };

      rust = {
        format = "[$symbol$version]($style) ";
        symbol = "🦀 ";
        style = "bold red";
      };

      nodejs = {
        format = "[$symbol$version]($style) ";
        symbol = " ";
        style = "bold green";
      };

      java = {
        format = "[$symbol$version]($style) ";
        symbol = " ";
        style = "bold red";
      };

      golang = {
        format = "[$symbol$version]($style) ";
        symbol = "🐹 ";
        style = "bold purple";
      };

      docker_context = {
        format = "[$symbol$context]($style) ";
        symbol = "🐳 ";
        style = "bold purple";
      };

      nix_shell = {
        format = "[$symbol$state]($style) ";
        symbol = " ";
        style = "bold red";
        impure_msg = "impure";
        pure_msg = "pure";
      };

      cmd_duration = {
        format = "[⏱ $duration]($style) ";
        style = "bold red";
        min_time = 500;
      };

      time = {
        disabled = false;
        format = "[$time]($style) ";
        style = "bold white";
        time_format = "%T";
      };
    };
  };
}