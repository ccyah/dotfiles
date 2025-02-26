ZIM_HOME=~/.zim

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
       # Chegnyu's stuff
# ------------------------------

# overriding /etc/zshrc
HISTSIZE=200000
SAVEHIST=100000
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording entry.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.

# alias
# alias vim="~/nvim-macos-arm64/bin/nvim"
alias vim="nvim"
alias lg="lazygit"
alias l="ls -lA --color"
alias lt="ls -lAtr --color"

# custom scripts
export PATH=$PATH:~/.local/bin

# use 1Password's ssh agent
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# fzf
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND="fd --hidden --type f --type l --exclude .git --exclude .jj" # use fd as finder and exclude .jj as well

# go
export PATH=$PATH:$(go env GOPATH)/bin

# opam configuration
[[ ! -r /Users/chengyuchen/.opam/opam-init/init.zsh ]] || source /Users/chengyuchen/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
