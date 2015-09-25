# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Don't let virtualenv mess with the custom prompt
export VIRTUAL_ENV_DISABLE_PROMPT='1'

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:~/npm/bin"
export PATH="$PATH:$HOME/.rvm/bin"

export RUST_SRC_PATH="$HOME/rust/src"
function cdp () {
    cd "$(python -c "import os.path as _, ${1}; \
            print(_.dirname(_.realpath(${1}.__file__[:-1])))"
        )"
}

# =================================
# Prompt Customization
# =================================
export EXIT_STATUS=0
export PROMPT_COMMAND=__prompt_command

function __capture_exit() {
  EXIT_STATUS="$?"
}

function __prompt_command() {
  local colReset="\[\e[0m\]"
  local colRed="\[\033[0;31m\]"
  local colGreen="\[\033[0;32m\]"
  local colLight="\[\033[0;37m\]"
  local colDark="\[\033[1;30m\]"

  PS1=""

  # exit status
  if [ $EXIT_STATUS != 0 ]; then
    PS1+="${colLight}(${colRed}$EXIT_STATUS${colLight})${colReset} "
  fi

  # date/time
  PS1+="${colLight}["
  PS1+="${colDark}\D{%F} \D{%H:%M:%S}"
  PS1+="${colLight}]${colReset} "

  # cwd
  PS1+="\w${colReset} "

  # color on exit status as well
  if [ $EXIT_STATUS != 0 ]; then
    PS1+="${colRed}"
  else
    PS1+="${colGreen}"
  fi

  # $/#
  PS1+="\$${colReset} "
}

# Always prepend PROMPT_COMMAND with __capture_exit so that it doesn't
# get lost by other commands (like pyenv)
export PROMPT_COMMAND="__capture_exit;$PROMPT_COMMAND"
