# vim:ft=zsh ts=2 sw=2 sts=2
#
# agnoster's Theme (Custom Red Theme variant)
# A Powerline-inspired theme for ZSH
#
# Customized with a beautiful red-based color scheme
# Colors: Deep Red (#8B0000), Crimson, Dark Gray, Light Gray, White

### Segments of the prompt, default order declaration

typeset -aHg AGNOSTER_PROMPT_SEGMENTS=(
    prompt_status
    prompt_context
    prompt_virtualenv
    prompt_dir
    prompt_git
    prompt_cmd_exec_time
    prompt_end
)

### Color definitions (using 256 colors for better appearance)
# Red palette: 52 (dark red), 88 (darker red), 124 (medium red), 160 (bright red), 196 (crimson)
# Gray palette: 234 (very dark), 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252 (light gray)
typeset -g COLOR_BG_DARK=235
typeset -g COLOR_BG_DARKER=234
typeset -g COLOR_RED_DARK=52
typeset -g COLOR_RED_MEDIUM=124
typeset -g COLOR_RED_BRIGHT=160
typeset -g COLOR_CRIMSON=196
typeset -g COLOR_GRAY_LIGHT=250
typeset -g COLOR_GRAY_MEDIUM=240
typeset -g COLOR_WHITE=15

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
if [[ -z "$PRIMARY_FG" ]]; then
	PRIMARY_FG=$COLOR_WHITE
fi

# Characters (Powerline symbols)
SEGMENT_SEPARATOR="\ue0b0"
SEGMENT_SEPARATOR_RIGHT="\ue0b2"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"
PYTHON="\U1F40D"  # 🐍
CLOCK="\u23F1"

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
# Dark gray background with white text for subtle but visible context
prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    if [[ -n "$SSH_CONNECTION" ]]; then
      # SSH connection: use crimson to highlight
      prompt_segment $COLOR_CRIMSON $COLOR_WHITE " $user@%m "
    else
      # Local: dark gray background
      prompt_segment $COLOR_BG_DARK $COLOR_GRAY_LIGHT " $user@%m "
    fi
  fi
}

# Git: branch/detached head, dirty status
# Clean: Dark red with white text
# Dirty: Bright red/crimson with white text for visibility
prompt_git() {
  local color ref git_status
  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules 2>/dev/null)"
  }
  
  ref="$vcs_info_msg_0_"
  if [[ -n "$ref" ]]; then
    # Determine color based on dirty status
    if is_dirty; then
      # Dirty: bright red/crimson to draw attention
      color=$COLOR_CRIMSON
    else
      # Clean: medium red, professional look
      color=$COLOR_RED_MEDIUM
    fi
    
    # Build the reference string
    local git_info=""
    
    # Check if we're in a branch or detached HEAD
    if [[ "${ref/.../}" == "$ref" ]]; then
      git_info="$BRANCH $ref"
    else
      git_info="$DETACHED ${ref/.../}"
    fi
    
    # Add dirty indicator
    if is_dirty; then
      git_info="${git_info} $PLUSMINUS"
    fi
    
    # Add ahead/behind indicators
    local ahead behind
    ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)
    behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)
    
    if [[ -n "$ahead" ]] && [[ "$ahead" -gt 0 ]]; then
      git_info="${git_info} ↑${ahead}"
    fi
    if [[ -n "$behind" ]] && [[ "$behind" -gt 0 ]]; then
      git_info="${git_info} ↓${behind}"
    fi
    
    # Add stash indicator
    local stash_count=$(git stash list 2>/dev/null | wc -l)
    if [[ "$stash_count" -gt 0 ]]; then
      git_info="${git_info} ⚑${stash_count}"
    fi
    
    prompt_segment $color $COLOR_WHITE
    print -n " $git_info "
  fi
}

# Dir: current working directory
# Bright red background with white text - the focal point
prompt_dir() {
  prompt_segment $COLOR_RED_BRIGHT $COLOR_WHITE ' %~ '
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{$COLOR_CRIMSON}%}$CROSS"
  [[ $UID -eq 0 ]] && symbols+="%{%F{$COLOR_CRIMSON}%}$LIGHTNING"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{$COLOR_GRAY_LIGHT}%}$GEAR"

  [[ -n "$symbols" ]] && prompt_segment $COLOR_BG_DARKER $COLOR_GRAY_LIGHT " $symbols "
}

# Display current virtual environment
# Light gray background with dark red text
prompt_virtualenv() {
  if [[ -n $VIRTUAL_ENV ]]; then
    prompt_segment $COLOR_GRAY_LIGHT $COLOR_RED_DARK
    print -Pn " $(basename $VIRTUAL_ENV) "
  fi
}

# Command execution time
# Shows how long the last command took to execute (if > 3 seconds)
prompt_cmd_exec_time() {
  local stop=$(date +%s)
  local start=${cmd_timestamp:-$stop}
  local elapsed=$((stop - start))
  
  if [[ $elapsed -gt 3 ]]; then
    local hours=$((elapsed / 3600))
    local minutes=$(((elapsed % 3600) / 60))
    local seconds=$((elapsed % 60))
    
    local time_str=""
    [[ $hours -gt 0 ]] && time_str="${hours}h "
    [[ $minutes -gt 0 ]] && time_str="${time_str}${minutes}m "
    time_str="${time_str}${seconds}s"
    
    prompt_segment $COLOR_GRAY_MEDIUM $COLOR_WHITE
    print -Pn " $CLOCK $time_str "
  fi
}

## Main prompt
prompt_agnoster_main() {
  RETVAL=$?
  CURRENT_BG='NONE'
  for prompt_segment in "${AGNOSTER_PROMPT_SEGMENTS[@]}"; do
    [[ -n $prompt_segment ]] && $prompt_segment
  done
}

prompt_agnoster_precmd() {
  vcs_info
  PROMPT='%{%f%b%k%}$(prompt_agnoster_main) '
}

# Capture command start time
prompt_agnoster_preexec() {
  cmd_timestamp=$(date +%s)
}

prompt_agnoster_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)
  setopt PROMPT_SUBST

  add-zsh-hook precmd prompt_agnoster_precmd
  add-zsh-hook preexec prompt_agnoster_preexec

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_agnoster_setup "$@"
