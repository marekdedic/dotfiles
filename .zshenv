export PATH="$HOME/.cargo/bin:$HOME/.config/composer/vendor/bin/:$HOME/.local/bin:$HOME/.local/bin/tunnel.sh:$PATH"
export ANDROID_HOME="/opt/android-sdk"

alias rm='trash'
alias up='
	sudo apt-get update &&
	sudo apt-get dist-upgrade -y &&
	sudo apt-get autoremove -y &&
	sudo apt-get autoclean &&
	sudo npm -g update &&
	$HOME/.tmux/plugins/tpm/bin/update_plugins all &&
	vim -c "PlugUpgrade|PlugUpdate|execute \"TSUpdateSync\"|qa" &&
	rustup update &&
	cargo install-update -a &&
	juliaup self update &&
	juliaup update &&
	pipx upgrade-all &&
	uv tool upgrade --all'
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'
alias nautilus='nohup nautilus . &>/dev/null &;disown'
alias julia='julia --project'

export EDITOR=nvim
export VISUAL=$EDITOR

# Suffix aliases
alias -s {css,html,java,jl,js,json,latte,md,php,py,scala,scss,svelte,tex,ts,tsx,txt,vue}=vim

export JULIA_NUM_THREADS=8

# Configure Zoxide to use non-exact matching in interactive mode
export _ZO_FZF_OPTS="--bind=ctrl-z:ignore,btab:up,tab:down --cycle --keep-right --border=sharp --height=45% --info=inline --layout=reverse --tabstop=2 --exit-0"

# Fzf configuration (Ctrl+T fuzzy find)
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# Workaround for docker bug
export DOCKER_BUILDKIT=0

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
