# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(fast-syntax-highlighting git zsh-autosuggestions zsh-nvm zsh-syntax-highlighting zsh-autocomplete)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
export EDITOR='nano'

# Alias definitions
alias a="cd ~/Work/web-admin && clear"
alias cook="cd ~/WhatJackHasMade/cook && clear"
alias cra="npx create-next-app@latest --ts --eslint --app --src-dir ."
alias d="npm run dev"
alias e2e="cd ~/Work/web-e2e-tests && clear"
alias fe="cd ~/WhatJackHasMade/fe-nextjs && clear"
alias g="cd ~/Work/web-graphql-server && clear"
alias gcf="git commit -m 'feat: $1'"
alias gcmp="git checkout main && git pull"
alias hub="cd ~/WhatJackHasMade/hub && clear"
alias hyperconfig="code ~/Support/Hyper/.hyper.js"
alias i="nvm use && npm i"
alias jp="cd ~/WhatJackHasMade/jackpritchard.co.uk"
alias p="cd ~/Work/web-portal && clear"
alias please="cd ~/WhatJackHasMade/please && clear"
alias play="DISABLE_LOG_QUEUE=true npx playwright test --project='Device: Desktop Chrome' --debug -g '$1'"
alias pt="DISABLE_LOG_QUEUE=true npx playwright test --project='Device: Desktop Chrome' --debug --grep='$1';"
alias pth="DISABLE_LOG_QUEUE=true npx playwright test --project='Device: Desktop Chrome' --grep='$1';"
alias s="cd ~/Work/web-signal && clear"
alias signal="cd ~/Work/web-signal && clear"
alias setenv='~/zshrc/setenv.zsh'
alias sync="cd ~/Sync && clear"
alias syncthing="open ~/Sync"
alias ubu="ssh ubuntu"
alias wjhm="cd ~/WhatJackHasMade/wjhm-nextjs && clear"
alias work="cd ~/Work/web-work-app && clear"

# Load nvm on cd
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

function copyLast() {
  # Get the last command from history using fc
  local last_command=$(fc -ln -1)

  # Copy to clipboard based on OS
  # macOS
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "$last_command" | pbcopy
  # Linux with xclip
  elif command -v xclip >/dev/null 2>&1; then
    echo "$last_command" | xclip -selection clipboard
  # Linux with xsel
  elif command -v xsel >/dev/null 2>&1; then
    echo "$last_command" | xsel --clipboard --input
  else
    echo "No clipboard utility found. Please install xclip or xsel."
  fi

  echo "Last command copied to clipboard!"
}

alias cl=copyLast

function gitpush() {
    git add .
    git commit -a -m "$1" --no-verify
    git push --no-verify
}
alias gg=gitpush

function gitpushonly() {
    git push --no-verify
}
alias gp=gitpushonly

function gitPrefix() {
    current_branch=$(git branch --show-current)
    new_branch="$1-$current_branch"
    git branch -m "$new_branch"
    git push origin -u "$new_branch"
    git push origin --delete "$current_branch"
}

alias prefix=gitPrefix

# Load nvm on cd
autoload -U add-zsh-hook

load-nvmrc() {
    local node_version=$(nvm version)
    if [ -f .nvmrc ]; then
        local nvmrc_path=$(nvm_find_nvmrc)
        local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

        if [ "$nvmrc_node_version" = "N/A" ]; then
            nvm install
        elif [ "$nvmrc_node_version" != "$node_version" ]; then
            nvm use
        fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
        echo "Reverting to nvm default version"
        nvm use default
    fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
