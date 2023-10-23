export PATH="$HOME/.cargo/bin:$HOME/.config/composer/vendor/bin/:$HOME/.local/bin:$HOME/.local/bin/tunnel.sh:$PATH"
export ANDROID_HOME="$HOME/AndroidSDK"

alias ls='exa'
alias ll='exa --long --group --git'
alias la='ll -a'
alias rm='trash'
alias up='
	sudo apt-get update &&
	sudo apt-get dist-upgrade -y &&
	sudo apt-get autoremove -y &&
	sudo apt-get autoclean &&
	sudo npm -g update &&
	$HOME/.tmux/plugins/tpm/bin/update_plugins all &&
	git -C $HOME/.oh-my-zsh/custom/themes/powerlevel10k pull &&
	git -C $HOME/.config/alacritty/themes pull &&
	vim -c PlugUpgrade\|PlugUpdate\|TSUpdateSync\|qa &&
	rustup update &&
	cargo install-update -a &&
	sudo env "PATH=$PATH" conda update conda -y &&
	omz update'
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'
alias nautilus='nohup nautilus . &>/dev/null &;disown'
alias julia='julia --project'

bindkey '^H' backward-kill-word # Ctrl-backspace

export EDITOR=nvim
export VISUAL=$EDITOR

# Suffix aliases
alias -s {pdf,}=evince
alias -s {css,html,java,jl,js,json,latte,md,php,py,scala,scss,svelte,tex,ts,tsx,txt,vue}=vim

export JULIA_NUM_THREADS=8

# Fzf configuration (Ctrl+T fuzzy find)
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# 1-parameter mv and cp
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
