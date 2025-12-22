{
  programs.starship = {
    enable = true;
    enableZshIntegration = false;  # Using custom Agnoster theme for ZSH
    enableBashIntegration = true;  # Enable for Bash and nix-shell
    
    settings = {
      # Powerline format with red theme matching Agnoster
      format = "$username$hostname$nix_shell$directory$git_branch$git_status$python$nodejs$rust$golang$line_break$character";
      add_newline = false;
      
      # Character (prompt symbol) - two lines for better readability
      character = {
        success_symbol = "[❯](bold red)";
        error_symbol = "[✘ ❯](bold bright-red)";
        vicmd_symbol = "[❮](bold red)";
      };
      
      # Username - only show in SSH
      username = {
        show_always = false;
        style_user = "bold white bg:235";
        style_root = "bold white bg:196";
        format = "[ $user ]($style)[](fg:235)";
      };
      
      # Hostname - only in SSH with powerline
      hostname = {
        ssh_only = true;
        style = "bold white bg:196";
        format = "[ @$hostname ]($style)[](fg:196)";
      };
      
      # Nix-shell indicator - FIRST segment with powerline arrow
      nix_shell = {
        symbol = "❄️  ";
        style = "bold white bg:52";  # Dark red
        format = "[ $symbol$name ]($style)[](fg:52 bg:160)";
        impure_msg = "";
        pure_msg = "";
        heuristic = true;
      };
      
      # Directory - the focal point with powerline
      directory = {
        style = "bold white bg:160";  # Bright red
        format = "[ $path ]($style)[](fg:160 bg:124)";
        truncation_length = 3;
        truncation_symbol = "…/";
        truncate_to_repo = true;
        read_only = " 🔒";
        home_symbol = "~";
      };
      
      # Git branch with powerline
      git_branch = {
        symbol = " ";
        style = "bold white bg:124";  # Medium red
        format = "[ $symbol$branch(:$remote_branch) ]($style)";
        truncation_length = 20;
        truncation_symbol = "…";
      };
      
      # Git status with powerline - changes color based on status
      git_status = {
        style = "bold white bg:124";
        conflicted = "⚔️ ";
        ahead = "⇡$count ";
        behind = "⇣$count ";
        diverged = "⇕⇡$ahead_count⇣$behind_count ";
        up_to_date = "";
        untracked = "?$count ";
        stashed = "⚑$count ";
        modified = "±$count ";
        staged = "+$count ";
        renamed = "»$count ";
        deleted = "✘$count ";
        format = "([$all_status$ahead_behind]($style))[](fg:124)";
      };
      
      # Language modules with powerline style
      python = {
        symbol = "🐍 ";
        style = "bold white bg:240";
        format = "[ $symbol$version ]($style)[](fg:240)";
        detect_extensions = ["py"];
        detect_files = ["requirements.txt" ".python-version" "pyproject.toml"];
      };
      
      nodejs = {
        symbol = " ";
        style = "bold white bg:240";
        format = "[ $symbol$version ]($style)[](fg:240)";
        detect_extensions = ["js" "mjs" "cjs" "ts"];
        detect_files = ["package.json" ".node-version"];
      };
      
      rust = {
        symbol = "🦀 ";
        style = "bold white bg:240";
        format = "[ $symbol$version ]($style)[](fg:240)";
        detect_extensions = ["rs"];
        detect_files = ["Cargo.toml"];
      };
      
      golang = {
        symbol = "🐹 ";
        style = "bold white bg:240";
        format = "[ $symbol$version ]($style)[](fg:240)";
        detect_extensions = ["go"];
        detect_files = ["go.mod" "go.sum"];
      };
      
      java = {
        symbol = "☕ ";
        style = "bold white bg:240";
        format = "[ $symbol$version ]($style)[](fg:240)";
      };
      
      # Package version
      package = {
        symbol = "📦 ";
        style = "bold white bg:240";
        format = "[ $symbol$version ]($style)[](fg:240)";
      };
      
      # Git metrics (optional but cool)
      git_metrics = {
        disabled = false;
        added_style = "bold green";
        deleted_style = "bold red";
        format = " [+$added]($added_style) [-$deleted]($deleted_style) ";
      };
      
      # Command duration
      cmd_duration = {
        min_time = 3000;  # Show if command took more than 3s
        style = "bold white bg:240";
        format = "[ ⏱ $duration ]($style)[](fg:240)";
      };
      
      # Memory usage (optional)
      memory_usage = {
        disabled = true;
        threshold = 75;
        symbol = "🧠 ";
        style = "bold white bg:240";
        format = "[ $symbol$ram ]($style)[](fg:240)";
      };
      
      # Time (optional)
      time = {
        disabled = true;
        style = "bold white bg:240";
        format = "[ 🕐 $time ]($style)[](fg:240)";
        time_format = "%H:%M";
      };
      
      # Battery (for laptops)
      battery = {
        full_symbol = "🔋";
        charging_symbol = "⚡";
        discharging_symbol = "💀";
        display = [
          { threshold = 10; style = "bold red"; }
          { threshold = 30; style = "bold yellow"; }
        ];
      };
    };
  };
}