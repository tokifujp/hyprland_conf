# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
## End of lines configured by zsh-newuser-install
## The following lines were added by compinstall
zstyle :compinstall filename '/home/tokifujp/.zshrc'

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -Uz compinit
compinit
# End of lines added by compinstall

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# vars
## concole lang
export LANG=en_US.utf8

## export GTK_USE_PORTA=1
## export GDK_DEBUG=portals

## $PATH
export PATH="/usr/lib/snapd/bin/:$PATH"
export PATH="/var/lib/snapd/snap/bin:$PATH"
export PATH="/home/tokifujp/.local/bin:$PATH"

## wayland
export XDG_DATA_DIRS="$XDG_DATA_HOME:/usr/local/share/:/usr/share/"
export XDG_DATA_DIR="$XDG_DATA_HOME:/usr/local/share/:/usr/share/"
export GSETTINGS_SCHEMA_DIR="/usr/share/glib-2.0/schemas"

# alias

## TERM for SSH
## export TERM=xterm
alias ssh='TERM=xterm-256color ssh'

## eza
alias ls='eza'
alias ll='eza -la'

## bat
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias bfind='find . -exec bat {} +'
batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

## fzf
alias ffind='find * -type f | fzf > selected'
alias fnvim='fzf --print0 | xargs -0 -o nvim'
alias gbat='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'

### fzf settings
# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

## bat aliases
alias fb='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# func
if [ -e /home/tokifujp/.nix-profile/etc/profile.d/nix.sh ]; then . /home/tokifujp/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
