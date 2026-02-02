### Starship

eval "$(starship init zsh)"

### Syntax highlighting

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Completion initialization

autoload -U compinit; compinit

### Ctrl+Left/Right/Backaspace

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^H' backward-kill-word

### History

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY

### Prefix history search using arrow keys

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search

### Enable highlighting for tab completions

zstyle ':completion:*' menu select

### Automatic cd

setopt autocd

### 1-parameter mv and cp

function mv() {
  if [ "$#" -ne 1 ] || [ ! -e "$1" ]; then
    command mv "$@"
    return
  fi

  newfilename="$1"
  vared newfilename
  command mv -v -- "$1" "$newfilename"
}

function cp() {
  if [ "$#" -ne 1 ] || [ ! -e "$1" ]; then
    command cp "$@"
    return
  fi

  newfilename="$1"
  vared newfilename
  command cp -v -r -- "$1" "$newfilename"
}

### Double escape key toggles sudo

source $HOME/.zsh_sudo

### Use eza instead of ls

alias ls='eza'
alias ll='eza --long --group --git'
alias la='ll -a'

### Safe rm

alias rm='trash'

### Use NeoVim as default editor

export EDITOR=nvim
export VISUAL=$EDITOR
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'

# Suffix aliases
alias -s {css,html,java,jl,js,json,latte,md,php,py,scala,scss,svelte,tex,ts,tsx,txt,vue}=vim

### Zoxide initialization

eval "$(zoxide init zsh)"

# Configure Zoxide to use non-exact matching in interactive mode
export _ZO_FZF_OPTS="--bind=ctrl-z:ignore,btab:up,tab:down --cycle --keep-right --border=sharp --height=45% --info=inline --layout=reverse --tabstop=2 --exit-0"

### Fzf configuration (Ctrl+T fuzzy find)

source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

### Always launch julia with project activated

alias julia='julia --project'

### Auto-detach nautilus

alias nautilus='nohup nautilus . &>/dev/null &;disown'

### Update everything

alias up='
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update &&
    sudo apt-get dist-upgrade -y &&
    sudo apt-get autoremove -y &&
    sudo apt-get autoclean &&
  fi &&
  sudo npm -g update &&
  $HOME/.tmux/plugins/tpm/bin/update_plugins all &&
  vim -c "PlugUpgrade|PlugUpdate|execute \"TSUpdateSync\"|qa" &&
  rustup update &&
  cargo install-update -a &&
  juliaup self update &&
  juliaup update &&
  pipx upgrade-all &&
  uv tool upgrade --all'

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=("$HOME/.juliaup/bin" $path)
export PATH

# <<< juliaup initialize <<<

# pnpm
export PNPM_HOME="/home/marekdedic/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
