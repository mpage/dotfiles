# For cowsay
export PATH="/usr/games:$PATH"

# Ruby
export PATH="$HOME/.rbenv/bin:/usr/local/heroku/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Personal binaries
export PATH="$HOME/bin:$PATH"

# Haskell
export PATH="$HOME/bin/ghc/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"

# Homebrew
export PATH="/usr/local/bin:$PATH"
export PATH="/Users/mpage/.local/bin:$PATH"

# Golang
export GOPATH="$HOME/src/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

set -o emacs


if [ -f /etc/environment ]; then
    . /etc/environment
fi

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

# Prompt
PS1="> "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Make Control-v paste, if in X and if xclip available - Josh Triplett
if [ -n "$DISPLAY" ] && [ -x /usr/bin/xclip ] ; then
    # Work around a bash bug: \C-@ does not work in a key binding
    bind '"\C-x\C-m": set-mark'
    # The '#' characters ensure that kill commands have text to work on; if
    # not, this binding would malfunction at the start or end of a line.
    bind 'Control-v: "#\C-b\C-k#\C-x\C-?\"$(xclip -o -selection c)\"\e\C-e\C-x\C-m\C-a\C-y\C-?\C-e\C-y\ey\C-x\C-x\C-d"'
fi

export EDITOR="mg"
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

if [ -z "$NOCOWSAY" ]; then
    cowsay -f ~/cows/ackcat.cow "`fortune`" | lolcat
fi

# OPAM configuration
. /Users/mpage/.opam/opam-init/init.sh >> /tmp/opam_init.out 2>> /tmp/opam_init.out

export SSH_AUTH_SOCK=/tmp/ssh-agent.sock
