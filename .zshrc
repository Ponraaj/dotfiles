# ~/.zshrc
# Set the GPG_TTY to be the same as the TTY, either via the env var
# or via the tty command.
if [ -n "$TTY" ]; then
  export GPG_TTY=$(tty)
else
  export GPG_TTY="$TTY"
fi

PATH="$HOME/go/bin:$PATH"
if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export EDITOR=vim

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

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q


# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

zle_highlight+=(paste:none)

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

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


alias v="nvim"
alias c="clear"
alias ls="eza -l --icons"
alias t="tmux"
alias lg="lazygit"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ponraaj/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ponraaj/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ponraaj/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ponraaj/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Run this command to disable starting up conda by default
# conda config --set auto_activate_base false

#Run this to activate conda
# conda activate base
source ~/completion-for-pnpm.zsh
source /usr/share/nvm/init-nvm.sh

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

export OLLAMA_HOST=0.0.0.0

