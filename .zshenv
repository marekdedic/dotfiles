export PATH="$HOME/.cargo/bin:$HOME/.config/composer/vendor/bin/:$HOME/.local/bin:$HOME/.local/bin/tunnel.sh:$PATH"
export ANDROID_HOME="$HOME/AndroidSDK"

alias rm='trash'
alias ls='ls --color=auto'
alias ll='ls -l'
alias up='
	sudo apt-get update &&
	sudo apt-get upgrade -y &&
	sudo apt-get autoremove -y &&
	sudo apt-get autoclean &&
	sudo npm -g update &&
	$HOME/.tmux/plugins/tpm/bin/update_plugins all &&
	omz update &&
	git -C $HOME/.oh-my-zsh/custom/themes/powerlevel10k pull
	vim -c PlugUpgrade\|PlugUpdate\|CocUpdateSync\|qa &&
	rustup update &&
	cargo install-update -a'
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'
alias nautilus='nohup nautilus . &>/dev/null &;disown'
alias julia='julia --project'
alias python='pipenv run python3'

bindkey '^H' backward-kill-word # Ctrl-backspace

export EDITOR=nvim
export VISUAL=$EDITOR

# Suffix aliases
alias -s {pdf,}=evince
alias -s {css,jl,js,md,php,py,tex,ts,vue}=vim

export JULIA_NUM_THREADS=8

export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

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
