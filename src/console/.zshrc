clear

export PATH="$HOME/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
plugins=(
  git
)
source $ZSH/oh-my-zsh.sh
# Basics
alias la="eza -la"
alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -l"
alias ~="cd ~"
alias co="cd ~/Code"
alias dn="cd ~/Code/Disney"
alias dnc="cd ~/Code/Disney/Configs"
# Git
alias gaa="git add -A"
alias gca="git add --all && git commit --amend --no-edit"
alias gco="git checkout"
alias gs="git status -sb"
alias gf="git fetch --all -p"
alias gps="git push"
alias gpsf="git push --force"
alias gpl="git pull --rebase --autostash"
alias gb="git branch"
# Utils
alias k='kill -9'
alias i.='(/Applications/IntelliJ\ IDEA\ CE.app/Contents/MacOS/idea $PWD &>/dev/null &)'
alias c.='(code $PWD &>/dev/null &)'
alias o.='open .'

#setopt prompt_subst

# Define colors
COLOR_CLEAN="%F{#FF9248}"
COLOR_DIRTY="%F{#ff4500}"
COLOR_GIT_ICON="%F{blue}"
COLOR_PROMPT="%F{cyan}"
COLOR_DIAMOND="%F{yellow}"
STATUS_ICON_COLOR_OK="%F{green}"
STATUS_ICON_COLOR_FAIL="%F{red}"
BUBBLE_BG_OK="%K{green}"
BUBBLE_BG_FAIL="%K{red}"
BUBBLE_FG="%F{black}"

# Function to shorten the path
short_pwd() {
  local current_dir="$PWD"
  local home_dir="$HOME"

  if [[ "$current_dir" == "$home_dir" ]]; then
    echo "~"
  else
    local relative_path="${current_dir#$home_dir/}"
    local path_parts=("${(@s:/:)relative_path}")
    local num_parts=${#path_parts[@]}

    if (( num_parts <= 2 )); then
      echo "~/${(j:/:)path_parts}"
    else
      local last_index=$(( num_parts ))
      local penultimate="${path_parts[last_index-1]}"
      local last="${path_parts[last_index]}"
      local num_dots=$(( num_parts > 10 ? 8 : num_parts - 2 ))
      local dots_prefix=$(printf '/..%.0s' {1..$num_dots})

      echo "~${dots_prefix}/${penultimate}/${last}"
    fi
  fi
}

# Function to get the current git branch and status
git_info() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)
    local changes=$(git status --porcelain 2>/dev/null | wc -l)
    local branch_color=$COLOR_CLEAN

    if (( changes > 0 )); then
      branch_color=$COLOR_DIRTY
    fi

    echo "${COLOR_GIT_ICON}%f ${branch_color}$branch%f"
  fi
}

# Set the prompt
PROMPT='%(?:%F{green}Duvan ❯%f:%F{red}Duvan ❯%f) '

# Function to update RPROMPT
update_rprompt() {
  RPROMPT="${COLOR_PROMPT}$(short_pwd)%f $(git_info)"
}

# Hook to update RPROMPT before each prompt
precmd_functions+=(update_rprompt)

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completionexport PATH="$HOME/bin:$PATH"


source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh