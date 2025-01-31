# oh-my-zsh foursight theme
# Adapted from clean and bureau themes

local user_symbol
local user_host="%B%(!.%{$fg[green]%}.%{$fg[green]%})%n@%m%{$reset_color%} "
local current_dir="%B%{$fg[blue]%}%~ %{$reset_color%}"

# ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg_bold[green]%} ±%{$reset_color%}%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_PREFIX="[ %{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} ]"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} ✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[cyan]%}▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%}▾%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[yellow]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STASHED="(%{$fg_bold[blue]%}*%{$reset_color%})"

# Functions to get current git status

git_info () {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
      echo "${ref#refs/heads/}"
    }

    git_status() {
      local result gitstatus
      gitstatus="$(command git status --porcelain -b 2>/dev/null)"

  # check status of files
  local gitfiles="$(tail -n +2 <<< "$gitstatus")"
  if [[ -n "$gitfiles" ]]; then
    if [[ "$gitfiles" =~ $'(^|\n)[AMRD]. ' ]]; then
      result+="$ZSH_THEME_GIT_PROMPT_STAGED"
    fi
    if [[ "$gitfiles" =~ $'(^|\n).[MTD] ' ]]; then
      result+="$ZSH_THEME_GIT_PROMPT_UNSTAGED"
    fi
    if [[ "$gitfiles" =~ $'(^|\n)\\?\\? ' ]]; then
      result+="$ZSH_THEME_GIT_PROMPT_UNTRACKED"
    fi
    if [[ "$gitfiles" =~ $'(^|\n)UU ' ]]; then
      result+="$ZSH_THEME_GIT_PROMPT_UNMERGED"
    fi
  else
    result+="$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi

  # check status of local repository
  local gitbranch="$(head -n 1 <<< "$gitstatus")"
  if [[ "$gitbranch" =~ '^## .*ahead' ]]; then
    result+="$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi
  if [[ "$gitbranch" =~ '^## .*behind' ]]; then
    result+="$ZSH_THEME_GIT_PROMPT_BEHIND"
  fi
  if [[ "$gitbranch" =~ '^## .*diverged' ]]; then
    result+="$ZSH_THEME_GIT_PROMPT_DIVERGED"
  fi

  # check if there are stashed changes
  if command git rev-parse --verify refs/stash &> /dev/null; then
    result+="$ZSH_THEME_GIT_PROMPT_STASHED"
  fi

  echo $result
}

get_git () {
  # ignore non git folders and hidden repos (adapted from lib/git.zsh)
  if ! command git rev-parse --git-dir &> /dev/null \
    || [[ "$(command git config --get oh-my-zsh.hide-info 2>/dev/null)" == 1 ]]; then
      return
  fi

  # check git information
  local gitinfo=$(git_info)
  if [[ -z "$gitinfo" ]]; then
    return
  fi

  # quote % in git information
  local output="${gitinfo:gs/%/%%}"

  # check git status
  local gitstatus=$(git_status)
  if [[ -n "$gitstatus" ]]; then
    output+=" $gitstatus"
  fi

  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${output}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

# Function to get number of spaces for split first line
get_space () {
  local STR=$1$2
  local zero='%([BSUbfksu]|([FB]|){*})'
  local LENGTH=${#${(S%%)STR//$~zero/}}
  local SPACES=$(( COLUMNS - LENGTH - ${ZLE_RPROMPT_INDENT:-1} ))

  (( SPACES > 0 )) || return
  printf ' %.0s' {1..$SPACES}
}

# Function to generate a user symbol
generate_emoticon() {
  local eyes=("^" "o" "O" "u" "•" "°" "ಠ" "⊙" "╹" "๑" "♥" "´" "ᵔ")
  local mouths=("v" "_" "o" "ᴗ" "‿" "ω" "w" "▽")

  local eye="${eyes[RANDOM % ${#eyes[@]} + 1]}"
  local mouth="${mouths[RANDOM % ${#mouths[@]} + 1]}"

  user_symbol="%{$fg[yellow]%}(>${eye}${mouth}${eye})> %B%b"
}

_FOURSIGHT_LEFT="${user_host}${current_dir}"
_FOURSIGHT_RIGHT="[ %* ]"

# Function to hook precmd
foursight_precmd () {
  _NUMSPACES=`get_space $_FOURSIGHT_LEFT $_FOURSIGHT_RIGHT`
  print -rP "$_FOURSIGHT_LEFT$_NUMSPACES$_FOURSIGHT_RIGHT"
}

setopt prompt_subst

autoload -U add-zsh-hook
add-zsh-hook precmd foursight_precmd
# add-zsh-hook precmd randomize_user_symbol
add-zsh-hook precmd generate_emoticon

PROMPT='$user_symbol'
RPROMPT='$(get_git)'
