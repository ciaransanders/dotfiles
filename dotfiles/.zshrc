# Don't freakin beep at me
unsetopt beep

# History settings
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
bindkey -v '^R' history-incremental-search-backward

# Fix backspace not deleting characters after entering vi command mode
bindkey -v '^?' backward-delete-char

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Hyprland settings to use uwsm
if uwsm check may-start 1>/dev/null && uwsm select; then
	exec uwsm start default
fi

# Aliases
source $HOME/.aliases

# Extra paths
path+=("$HOME/.local/bin")
path+=("$HOME/bin")

# Disable showing the current venv in prompt
VIRTUAL_ENV_DISABLE_PROMPT=1

# version control function provided by zsh
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '%F{5}%f %F{5}[%F{2}%b%f%F{5}] %m%u%c %a'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}-%f'

# Prompt
setopt prompt_subst
precmd() { vcs_info }
PS1='%F{3}%B%~%b%f ${vcs_info_msg_0_}%f$ '

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init - zsh)"

# Yazi shell wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Environment variables
export EDITOR=nvim

# Machine-local secrets, not tracked
[[ -f ~/.config/dotfiles/env.private ]] && source ~/.config/dotfiles/env.private
