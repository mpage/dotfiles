# -*- mode: sh; -*-
#

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

# ls
alias la='ls -latrh'

# find
alias fbn='find . -name'

# git
alias g='git'
alias gco='git checkout'
alias gst='git status'
alias gbr='git branch'

# ruby
alias be='bundle exec'
alias bi='bundle install'
alias bers='bundle exec rake spec'
alias rs='ruby -S rspec --color --format documentation'

# random
alias ac='apt-cache'
alias ..='cd ..'
