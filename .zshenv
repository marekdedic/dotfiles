export PATH="$HOME/.cargo/bin:$HOME/.config/composer/vendor/bin/:$HOME/.local/bin:$HOME/.local/bin/tunnel.sh:$PATH"
export ANDROID_HOME="$HOME/AndroidSDK"

alias rm='trash'
alias ls='ls --color=auto'
alias ll='ls -l'
alias up='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean && sudo npm -g update && $HOME/.tmux/plugins/tpm/bin/update_plugins all && upgrade_oh_my_zsh && vim -c PlugUpgrade\|PlugUpdate\|q\|q && rustup update && cargo install-update -a'
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'
alias nautilus='nohup nautilus . &>/dev/null &;disown'
alias julia='julia --project'
alias python='pipenv run python'

bindkey '^H' backward-kill-word # Ctrl-backspace

export EDITOR=nvim
export VISUAL=$EDITOR

export JULIA_NUM_THREADS=8

export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_ETC_ICON=''
POWERLEVEL9K_VCS_UNTRACKED_ICON='\uF128'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\uF111'
POWERLEVEL9K_VCS_STAGED_ICON='\uF067'

function mv() {
  if [ "$#" -ne 1 ] || [ ! -e "$1" ]; then
    command mv "$@"
    return
  fi

  newfilename="$1"
  vared newfilename
  command mv -v -- "$1" "$newfilename"
}
