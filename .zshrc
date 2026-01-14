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

### FZF

source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

### Double escape for sudo

source $HOME/.zsh_sudo

### Zoxide

eval "$(zoxide init zsh)"

### These aliases need to be here, they get overriden in .zshenv
alias ls='eza'
alias ll='eza --long --group --git'
alias la='ll -a'

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
