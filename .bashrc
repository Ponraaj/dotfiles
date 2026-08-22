#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
if [ ! -z "$PS1" ]; then
    exec /bin/zsh $*
fi 

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ponraaj/Miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ponraaj/Miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/ponraaj/Miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ponraaj/Miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


. "$HOME/.moon/bin/env"

# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"
