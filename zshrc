# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="agnoster"
# ZSH_THEME="avit"
ZSH_THEME="alanpeabody"
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"


# Custom Settings #
# Custom Settings #
# Custom Settings #
# Custom Settings #


WIDTH=$(tput cols)

#checks for applications
if which figlet >/dev/null; then
    FIGLET=1
else
    FIGLET=0
fi

if which toilet >/dev/null; then
    TOILET=1
  else
    TOILET=0
fi

if [ -f ~/.window_remap.sh ]; then
    REMAP=1
else
    REMAP=0 
fi


function welcome() { # cute welcome msg also more stuff these days
if [ $UID -eq "0" ]; then
  alias rm="rm -i"
  alias cp="cp -i"
  alias mv="mv -i"
  if [ $FIGLET -eq "1" ]; then
      figlet -w ${WIDTH} -f gothic -c root 
    else
      echo "root"
  fi
else
  if [ ${WIDTH} -gt "80" ]; then
    if [ $FIGLET -eq "1" ]; then
      figlet -w ${WIDTH} -c -f fraktur "Welcome Piet" #| toilet -f term -filter gay -w 160 // could not load font ilter (?!??!)
      if [ $TOILET -eq "1" ]; then
        date | figlet -f term -c -w ${WIDTH} | toilet -f term -w ${WIDTH} --gay
        /usr/games/fortune | figlet -f term -c -w ${WIDTH} | toilet -f term -w ${WIDTH}
        echo ❤  | figlet -f term -c -w ${WIDTH}
      else 
        date | figlet -f term -c -w ${WIDTH}
        /usr/games/fortune | figlet -f term -c -w ${WIDTH} 
      fi
      uname -smr | figlet -f term -c -w ${WIDTH}
      if [ $REMAP -eq "1" ]; then
        ~/.window_remap.sh #should really check for this
      fi
    else
      echo "Welcome Piet"
      date
      uname -smr
      cal -3
      cat ~/.notes.txt
    fi
  fi
fi
}
welcome

extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1       ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not valid for extraction"
  fi
}

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

export EDITOR=vim
alias twb="cd ~/workspace/twb/twb"

alias ff='sudo find / -name $1'
alias install='sudo apt-get install'

alias school='ssh pietdan@choplifter.ccs.neu.edu'

alias tether='/home/civil/DroidTetherSV/droidtethersv'

alias newreg='ssh pietdan@129.10.113.117'

alias ccat='pygmentize -g' 
alias def='sdcv $1'

alias serve='python -m SimpleHTTPServer'

VST_PATH=/home/civil/personal/my_music/rns_2_8_2_reg_x86/Resources/Plugins:/home/civil/personal/my_music/rns_2_8_2_reg_x86/Resources/Plugins/*:$VST_PATH
export VST_PATH
LADSPA_PATH=/home/civil/personal/my_music/rns_2_8_2_reg_x86/Resources/Plugins:/home/civil/personal/my_music/rns_2_8_2_reg_x86/Resources/Plugins/*:$LADPSA_PATH
export LADSPA_PATH


# set up vim
bindkey -v
# goodies for vim mode
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
# git prompt stuff is copied from alean pebody theme local var
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$(git_prompt_status)%{$reset_color%}$(git_prompt_info)%{$reset_color%} $EPS1"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
# default .4 seconds ... but why
export KEYTIMEOUT=0
