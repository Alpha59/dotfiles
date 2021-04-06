source ~/.bash_profile_work
alias ls='exa -l '
alias bc='bc -l '
alias dammit='docker-compose down; docker-compose up -d '
alias sudo=' '
alias fucking='\sudo '
alias fucking!='fucking $(history -p !!)'
alias startUp='npm run start-dev '
alias simpleserver='Python -m SimpleHTTPServer '
alias clear='clear;clear;clear;clear;clear;clear;clear;clear; '
alias lynx='lynx -accept_all_cookies '
alias cvim='charm '
# alias vim='nvim '
alias keyadd='ssh-add -K ~/.ssh/ '
alias autopep='autopep8 -i -r -a -a '
alias mongos='mongodb --dbpath /usr/local/data/db/ '
alias note='jrnl '
alias rm='trash '
alias top='vtop '
alias cat='ccat '
alias fp='$(history -p !!)| fpp'
alias find='locate_ffp '
alias weather='curl wttr.in/seattle'
alias bb='brazil-build '
alias grep='grep -Is '
alias python='/usr/local/Cellar/python/3.7.7/bin/python3 '
#alias python='/usr/local/bin/python3 '
alias pip='pip3 '
alias ta='tmux a '
alias vpn='/opt/cisco/anyconnect/bin/vpn connect "Automatic Selection (Route53)"'
alias vpn_bin='/opt/cisco/anyconnect/bin/vpn '
alias myip='curl icanhazip.com'
alias ninja='tmux kill-session -t ninja; tmux new-session -d -s ninja "ninja-dev-sync" '
alias checkstyle='java -jar ~/Downloads/checkstyle-8.18-all.jar -c checkstyle-config.xml '
alias diff-pretty='diff2html --sc "enabled" -s "side" --lm words '
alias diff-vim='git difftool --tool=vimdiff '
alias screenshot='screencapture -ic '
# alias pull-request='gtm commit -yes; hub pull-request -a "alpha59" --no-edit -o -p -l "team-pwa" '

export CLICOLOR=1
export LSCOLORS="exfxcxdxbxegedabagacad"

export PROMPT="\t:\w>Yes Jake? >> "
export PS1="t$PROMPT"

set -o vi

export PATH=$PATH:/usr/local/opt/mongodb/bin/mongoexport:$GOPATH/bin:$HOME/scripts/:$HOME/.scripts/:$HOME/git-extra-commands/bin/:/usr/local/Cellar/node/11.6.0/bin/:$HOME/.scarf/bin/

# Pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH:$HOME/scripts/"
#eval "$(pyenv init -)"

eval $(thefuck --alias)
complete -W "$(teamocil --list)" teamocil
stty erase '^?'

if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
  . `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

# Move next only if `homebrew` is installed
if command -v brew >/dev/null 2>&1; then
    # Load rupa's z if installed
    [ -f $(brew --prefix)/etc/profile.d/z.sh ] && source $(brew --prefix)/etc/profile.d/z.sh
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

source gtm-plugin.sh
#source ~/codechecker/venv/bin/activate
