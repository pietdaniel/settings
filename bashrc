# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# ~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~ #
# 101                     custom stuff here                         #
# ~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~ #


WIDTH=$(tput cols)
# im suspicious of tput?!?!?
if [ $WIDTH -eq "0" ]; then
  WIDTH=80
fi

function myip() # get IP adresses this could use some work
{
#  MY_IP=$(/sbin/ifconfig eth0 | awk "/inet/ { print $2 } " | sed -e s/addr://)
#  MY_ISP=$(/sbin/ifconfig eth0 | awk "/P-t-P/ { print $3 } " | sed -e s/P-t-P://)
#  myip=`elinks -dump http://checkip.dyndns.org:8245/`
if which lynx >/dev/null; then
    lynx -dump -hiddenlinks=ignore -nolist "http://checkip.dyndns.org:8245/" | grep "Current IP Address" | cut -d":" -f2 | cut -d" " -f2 
  else
    echo "127.0.0.1"
fi
}

if which figlet >/dev/null; then
    FIGLET=1
  else
    FIGLET=0
fi

function welcome() { # cute welcome msg
if [ $UID -eq "0" ]; then
  if [ $FIGLET -eq "1" ]; then
      figlet -w ${WIDTH} -f gothic -c root 
    else
      echo "root"
  fi
else
  if [ $FIGLET -eq "1" ]; then
    figlet -w ${WIDTH} -c -f fraktur "Welcome Daniel" #| toilet -f term -filter gay -w 160 // could not load font ilter (?!??!)
    date | figlet -f term -c -w ${WIDTH} | toilet -f term -w ${WIDTH} --gay
    /usr/games/fortune | figlet -f term -c -w ${WIDTH} | toilet -f term -w ${WIDTH}
    uname -smr | figlet -f term -c -w ${WIDTH}
    ~/.window_remap.sh #should really check for this
    #myip | figlet -f term -c -w ${WIDTH}
  else
    echo "Welcome Daniel"
    date
    uname -smr
    #myip
    cal -3
    cat ~/.notes.txt
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



PS1="\[\033[1;32m\][\D{%a:%d}|\$(date +%H:%M)][\w]$\[\033[0m\] "

if [ $UID -eq "0" ]; then
  PS1="\[\033[1;31m\][\D{%a:%d}|\$(date +%H:%M)][\w]#\[\033[0m\] "
fi

alias top-commands='history | awk "{print $2}" | awk "BEGIN {FS="|"} {print $1}" |sort|uniq -c | sort -rn | head -10'
alias ff='sudo find / -name $1'
alias install='sudo apt-get install'
alias cred='cat Documents/credentials.txt'
alias ls='ls --color'
alias l='ls -al'
alias turnin_systems='/course/cs3600f13/bin/turnin'
alias mpull='git pull origin master'
alias gc='git checkout '
alias gb='git branch '
alias push='git push origin '
alias commit='git commit -m '
alias st='git status'
alias add='git add'
alias pull='git pull origin'
alias school='ssh pietdan@login.ccs.neu.edu'
alias q='clear'
alias tether='/home/civil/DroidTetherSV/droidtethersv'
