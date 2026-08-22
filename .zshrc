# ~/.zshrc
# Set the GPG_TTY to be the same as the TTY, either via the env var
# or via the tty command.
if [ -n "$TTY" ]; then
  export GPG_TTY="$TTY"
else
  export GPG_TTY=$(tty)
fi

PATH="$HOME/go/bin:$PATH"
if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export EDITOR=nvim

# SSH_AUTH_SOCK set to GPG to enable using gpgagent as the ssh agent.
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light chitoku-k/fzf-zsh-completions
zinit light Aloxaf/fzf-tab
zinit light zdharma-continuum/history-search-multi-word
# zinit ice atload"zpcdreplay" atclone"./zplug.zsh" atpull"%atclone"
# zinit light g-plane/pnpm-shell-completion

# Add in snippets
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

fpath+=~/.zfunc

# Load completions with caching (speeds up startup)
autoload -Uz compinit
if [[ ! -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ]]; then
  mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
fi
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"

zinit cdreplay -q


# Keybindings
# bindkey -e
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward
# bindkey '^[w' kill-region

zle_highlight+=(paste:none)

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Shell History with Atuin (Magical Shell History)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Atuin replaces traditional history with SQLite-backed, syncable, searchable history
# Keybinding: Ctrl+R (replaces default history search)

if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Directory Environment with Direnv
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Auto-load environment variables from .envrc files in directories
# Usage: echo 'export API_KEY=xxx' > .envrc && direnv allow

if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# if command -v tmux &> /dev/null; then
#     if [[ -z "$TMUX" ]]; then
#         # If not in a tmux session, attach or create a new one
#         tmux attach-session -d || tmux new-session
#     fi
# fi

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Modern CLI Aliases & DX Improvements
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Core aliases
alias v="nvim"
alias c="clear"
alias t="tmux"
alias lg="lazygit"

# Enhanced ls with eza (already set up)
alias ls="eza -l --icons"
alias la="eza -la --icons"
alias lt="eza --tree --icons"
alias l="eza -la --icons"

# Modern replacements (if installed)
if command -v bat &> /dev/null; then
  alias cat="bat --style=plain --paging=never"
  alias catf="bat"  # Full bat with paging
fi

if command -v fd &> /dev/null; then
  alias find="fd"
fi

if command -v rg &> /dev/null; then
  alias grep="rg"
fi

# Git shortcuts
alias g="git"
alias gs="git status"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit"
alias gcm="git commit -m"
alias gco="git checkout"
alias gb="git branch"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log --oneline --graph -10"
alias gp="git push"
alias gpl="git pull"
alias gst="git stash"
alias gsp="git stash pop"

# Tmux shortcuts
alias ta="tmux attach"
alias tat="tmux attach -t"
alias tn="tmux new -s"
alias tl="tmux list-sessions"
alias tk="tmux kill-session -t"
alias ts="tmux switch -t"
alias tns="tmux new-session -A -s"
alias tks="tmux kill-server"

# Quick navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"

# Safety aliases
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Useful shortcuts
alias mkdir="mkdir -p"
alias ports="netstat -tulanp"
alias mem="free -h"
alias disk="df -h"
alias path="echo $PATH | tr ':' '\n'"

# Edit configs quickly
alias zshrc="v ~/.zshrc"
alias vimrc="v ~/.config/nvim"
alias tmuxconf="v ~/.config/tmux/tmux.conf"
alias reload="source ~/.zshrc"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Sesh + Tmux Integration (keyboard-centric)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Sesh aliases
alias ss="sesh connect"
alias sl="sesh list"
alias st="sesh list -t"
alias sz="sesh list -z"
alias sroot="sesh connect --root"
alias slast="sesh last"

# Sesh picker using gum (fast, modern UI)
sesh-gum() {
  local session
  session=$(sesh list -i | gum filter --limit 1 --no-sort --no-strip-ansi --fuzzy --placeholder 'Pick a sesh' --height 50 --prompt='⚡')
  [[ -z "$session" ]] && return
  sesh connect "$session"
}

# Sesh picker using fzf (fallback)
sesh-fzf() {
  local session
  session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
  [[ -z "$session" ]] && return
  sesh connect "$session"
}

# Zle keybind (Alt-s) for sesh picker
if command -v sesh &> /dev/null; then
  function sesh-sessions() {
    {
      exec </dev/tty
      exec <&1
      local session
      if command -v gum &> /dev/null; then
        session=$(sesh list -i | gum filter --limit 1 --no-sort --no-strip-ansi --fuzzy --placeholder 'Pick a sesh' --height 50 --prompt='⚡')
      else
        session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
      fi
      zle reset-prompt > /dev/null 2>&1 || true
      [[ -z "$session" ]] && return
      sesh connect "$session"
    }
  }

  zle -N sesh-sessions
  bindkey -M emacs '\es' sesh-sessions
  bindkey -M vicmd '\es' sesh-sessions
  bindkey -M viins '\es' sesh-sessions
fi

# Optional: auto-attach to tmux on shell start
# if command -v tmux &> /dev/null; then
#   if [[ -z "$TMUX" ]]; then
#     tmux attach-session -d || tmux new-session
#   fi
# fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# FZF Configuration (Fuzzy Finder)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Use fd for fzf (respects .gitignore, faster)
if command -v fd &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Catppuccin theme for fzf
export FZF_DEFAULT_OPTS="
  --height 60%
  --layout=reverse
  --border=rounded
  --preview-window=right:50%
  --prompt='∼ '
  --pointer='▶'
  --marker='✓'
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
"

# FZF key bindings (if available)
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
fi
if [ -f /usr/share/fzf/completion.zsh ]; then
  source /usr/share/fzf/completion.zsh
fi

# Custom fzf functions
# Fuzzy cd - cd into directory with preview
fcd() {
  local dir
  dir=$(fd --type d --hidden --follow --exclude .git | fzf --preview 'eza --tree --icons --level=2 {}') && cd "$dir"
}

# Fuzzy kill - kill process (uses procs if available, falls back to ps)
fkill() {
  local pid
  if command -v procs &> /dev/null; then
    pid=$(procs | fzf -m --header='[kill process]' --preview 'echo {}' --preview-window=down:3 | awk '{print $1}')
  else
    pid=$(ps -ef | sed 1d | fzf -m --header='[kill process]' | awk '{print $2}')
  fi
  if [ -n "$pid" ]; then
    echo $pid | xargs kill -${1:-9}
  fi
}

# Fuzzy git checkout branch
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m --header='[git branch]') &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed 's/.* //')
}

# Fuzzy git log and show commit (uses delta if available for better diffs)
fshow() {
  local show_cmd="git show --color=always"
  if git config --get core.pager &>/dev/null | grep -q delta; then
    show_cmd="git show"
  fi
  git log --graph --color=always --format='%C(auto)%h%d %s %C(black)%C(bold)%cr' "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort --header='[git log]' \
      --bind "ctrl-m:execute:echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c '$show_cmd % | less -R'"
}

# Fuzzy history search (uses atuin if available, falls back to fzf)
fh() {
  if command -v atuin &> /dev/null; then
    # Use atuin search with interactive UI
    local cmd
    cmd=$(atuin search --interactive --limit 1 2>/dev/null)
    if [ -n "$cmd" ]; then
      print -z "$cmd"
    fi
  else
    # Fallback to fzf with fc
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac --header='[history]' | sed -E 's/^[0-9]+\*? +//')
  fi
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Useful Functions
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Quick file extraction
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.tar.xz)    tar xJf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Create directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Get public IP
myip() {
  curl -s https://ipinfo.io/ip
}

# Weather (wttr.in)
weather() {
  curl -s "wttr.in/${1:-}?format=3"
}

# Serve current directory on port
serve() {
  local port="${1:-8000}"
  python3 -m http.server "$port"
}

# Backup file with timestamp
backup() {
  cp "$1" "${1}.backup.$(date +%Y%m%d_%H%M%S)"
}

# Search and replace in files (uses sd if available, falls back to sed)
replace() {
  if [ $# -ne 3 ]; then
    echo "Usage: replace <search> <replace> <file>"
    return 1
  fi
  if command -v sd &> /dev/null; then
    sd "$1" "$2" "$3"
  else
    sed -i "s/$1/$2/g" "$3"
  fi
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Modern Tool Utility Functions
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# View file with bat (with optional line number)
view() {
  if command -v bat &> /dev/null; then
    if [ -n "$2" ]; then
      bat --line-range "$2" "$1"
    else
      bat "$1"
    fi
  else
    cat "$1"
  fi
}

# Search in files with ripgrep and preview with bat
search() {
  if command -v rg &> /dev/null && command -v bat &> /dev/null && command -v fzf &> /dev/null; then
    rg --color=always --line-number --no-heading "$1" | \
    fzf --ansi --delimiter ':' \
        --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
        --preview-window 'up:60%:wrap:+{2}+3/3' \
        --bind 'enter:execute(nvim +{2} {1})'
  else
    grep -rn "$1" .
  fi
}

# Find files with fd and open with fzf preview
findf() {
  if command -v fd &> /dev/null && command -v fzf &> /dev/null; then
    fd --type f --hidden --follow --exclude .git "$@" | \
    fzf --preview 'bat --style=numbers --color=always {}' \
        --preview-window 'right:60%' \
        --bind 'enter:execute(nvim {})'
  else
    find . -type f -name "*$1*" 2>/dev/null
  fi
}

# Quick directory size analysis with dua or du
size() {
  if command -v dua &> /dev/null; then
    dua i "$@"
  else
    du -sh "$@" 2>/dev/null | sort -h
  fi
}

# System monitor (btop, btm, or top)
mon() {
  if command -v btop &> /dev/null; then
    btop
  elif command -v btm &> /dev/null; then
    btm
  else
    top
  fi
}

# List processes with procs or ps
processes() {
  if command -v procs &> /dev/null; then
    procs "$@"
  else
    ps aux | grep -i "$1"
  fi
}

# Calculate disk usage for current directory
duhere() {
  if command -v dua &> /dev/null; then
    dua "$@"
  elif command -v dust &> /dev/null; then
    dust "$@"
  else
    du -sh .[^.]* * 2>/dev/null | sort -h
  fi
}

# Quick JSON/YAML/TOML formatter
fmtfile() {
  local file="$1"
  local ext="${file##*.}"
  
  case "$ext" in
    json)
      if command -v jq &> /dev/null; then
        jq . "$file" | bat -l json
      else
        cat "$file"
      fi
      ;;
    yaml|yml)
      if command -v yq &> /dev/null; then
        yq . "$file" | bat -l yaml
      else
        cat "$file"
      fi
      ;;
    toml)
      if command -v yq &> /dev/null; then
        yq -p toml . "$file" | bat -l toml
      else
        cat "$file"
      fi
      ;;
    *)
      cat "$file"
      ;;
  esac
}

# Quick HTTP request with curl and pretty print JSON
get() {
  if command -v jq &> /dev/null; then
    curl -s "$1" | jq . | bat -l json
  else
    curl -s "$1"
  fi
}

# Smart cd - use zoxide, yazi, or fzf in order of preference
smartcd() {
  if [ $# -eq 0 ]; then
    if command -v yazi &> /dev/null; then
      yy
    elif command -v fzf &> /dev/null && command -v fd &> /dev/null; then
      fcd
    else
      cd
    fi
  else
    if command -v zoxide &> /dev/null; then
      z "$@"
    else
      cd "$@"
    fi
  fi
}

# Git diff with delta integration
gdiff() {
  if command -v delta &> /dev/null; then
    git diff "$@" | delta
  else
    git diff "$@"
  fi
}

# Interactive git status with lazygit or tig
gstatus() {
  if command -v lazygit &> /dev/null; then
    lazygit
  elif command -v tig &> /dev/null; then
    tig status
  else
    git status
  fi
}

# List recent files with eza or ls
recent() {
  if command -v eza &> /dev/null; then
    eza --sort=modified --reverse --long --icons "$@"
  else
    ls -lt "$@" | head -20
  fi
}

# Tree view with eza or tree
treef() {
  if command -v eza &> /dev/null; then
    eza --tree --icons "$@"
  elif command -v tree &> /dev/null; then
    tree "$@"
  else
    find . -maxdepth 2 -type d | sed 's|[^/]*/| |g'
  fi
}

# Quick edit - open file with nvim or fallback to editor
edit() {
  if command -v nvim &> /dev/null; then
    nvim "$@"
  else
    ${EDITOR:-vi} "$@"
  fi
}

# Check what is using a port
port() {
  local port="$1"
  if command -v lsof &> /dev/null; then
    lsof -i :"$port"
  elif command -v ss &> /dev/null; then
    ss -tuln | grep ":$port"
  elif command -v netstat &> /dev/null; then
    netstat -tuln | grep ":$port"
  else
    echo "No network tool available"
  fi
}

# Quick compression with zstd/pigz or gzip
compress() {
  local file="$1"
  if [ -z "$file" ]; then
    echo "Usage: compress <file_or_directory>"
    return 1
  fi
  
  if command -v zstd &> /dev/null; then
    zstd -19 --rm "$file"
  elif command -v pigz &> /dev/null; then
    pigz -9 "$file"
  else
    gzip -9 "$file"
  fi
}

# Cheatsheet lookup with tealdeer or man
cheat() {
  if command -v tldr &> /dev/null; then
    tldr "$@"
  elif command -v cheat &> /dev/null; then
    cheat "$@"
  else
    man "$@" 2>/dev/null || "$@" --help 2>/dev/null || "$@" -h 2>/dev/null
  fi
}

# Quick note taking
note() {
  local notes_dir="${NOTES_DIR:-$HOME/notes}"
  mkdir -p "$notes_dir"
  if [ $# -eq 0 ]; then
    # Open today's note
    local today=$(date +%Y-%m-%d)
    edit "$notes_dir/$today.md"
  else
    # Create or open specific note
    edit "$notes_dir/$1.md"
  fi
}

# Quick todo management
todo() {
  local todo_file="${TODO_FILE:-$HOME/todo.txt}"
  if [ $# -eq 0 ]; then
    # Show todos
    if [ -f "$todo_file" ]; then
      bat "$todo_file" 2>/dev/null || cat "$todo_file"
    else
      echo "No todos yet!"
    fi
  elif [ "$1" = "done" ] || [ "$1" = "-d" ]; then
    # Mark as done (remove line)
    shift
    local pattern="$*"
    if [ -f "$todo_file" ]; then
      sed -i "/$pattern/d" "$todo_file"
      echo "Removed: $pattern"
    fi
  else
    # Add todo
    echo "[ ] $(date '+%Y-%m-%d %H:%M') - $*" >> "$todo_file"
    echo "Added: $*"
  fi
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Yazi File Manager Integration
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Usage: yy (opens yazi, changes directory when you quit)
# Or just: yazi (opens without cd on exit)

if command -v yazi &> /dev/null; then
  function yy() {
    local tmp
    tmp=$(mktemp -t "yazi-cwd.XXXXXX")
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      cd -- "$cwd"
    fi
    rm -f -- "$tmp"
  }
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Modern CLI Tool Configurations
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Bat - Better cat
if command -v bat &> /dev/null; then
  export BAT_THEME="Catppuccin Mocha"
  export BAT_STYLE="numbers,changes,header"
fi

# Delta - Better git diff (configured in ~/.gitconfig)
# Already configured with catppuccin theme

# Eza - Better ls (already aliased)

# Btop - System monitor
if command -v btop &> /dev/null; then
  export BTOP_THEME="catppuccin"
fi

# Procs - Better ps
if command -v procs &> /dev/null; then
  alias ps="procs"
fi

# Dua - Disk usage analyzer
if command -v dua &> /dev/null; then
  alias du="dua"
fi

# Bandwhich - Network monitor
if command -v bandwhich &> /dev/null; then
  alias bandw="sudo bandwhich"
fi

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# >>> conda initialize (LAZY LOADED for performance) >>>
# Only initializes when you first run 'conda' command
function conda() {
  unset -f conda
  local __conda_setup="$('/home/ponraaj/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "/home/ponraaj/miniconda3/etc/profile.d/conda.sh" ]; then
      . "/home/ponraaj/miniconda3/etc/profile.d/conda.sh"
    else
      export PATH="/home/ponraaj/miniconda3/bin:$PATH"
    fi
  fi
  conda "$@"
}
# <<< conda initialize <<<
source ~/completion-for-pnpm.zsh
source /usr/share/nvm/init-nvm.sh

# # Docker
# export DOCKER_HOST="unix:///home/ponraaj/.docker/desktop/docker.sock"

# pnpm
export PNPM_HOME="/home/ponraaj/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH=$HOME/.local/bin:$PATH


# bun completions
[ -s "/home/ponraaj/.bun/_bun" ] && source "/home/ponraaj/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# cargo
export PATH="$PATH:$HOME/.cargo/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ponraaj/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ponraaj/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ponraaj/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ponraaj/google-cloud-sdk/completion.zsh.inc'; fi

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - zsh)"

export OLLAMA_HOST=0.0.0.0


# opencode
export PATH=/home/ponraaj/.opencode/bin:$PATH

# Added by flyctl installer
export FLYCTL_INSTALL="/home/ponraaj/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Performance Optimizations (Added)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Deduplicate PATH entries (maintains order, removes duplicates)
typeset -U PATH

. "$HOME/.moon/bin/env"

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit && compinit -C
# <<< grok installer <<<

# kimi-code
export PATH="/home/ponraaj/.kimi-code/bin:$PATH"

# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"

# Turso
export PATH="$PATH:/home/ponraaj/.turso"

# load local secrets (keys live in ~/.secrets, never commit)
if [ -f ~/.secrets/opencode-go.env ]; then
  set -a; source ~/.secrets/opencode-go.env; set +a
fi
