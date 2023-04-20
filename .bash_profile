# shellcheck source=/dev/null
#shellcheck -x
export EDITOR='vim'
#export PAGER='less'
export WEECHAT_HOME=~/.weechat;
export CLICOLOR=1;
export LSCOLORS="exfxcxdxbxegedabagacad";

export PROMPT="\t:\w>Yes Jake? >> ";
export PS1="$PROMPT";

#set -o vi

PATH="$PATH:$(/opt/homebrew/bin/brew --prefix)/opt/python3/libexec/bin";
PATH="$PATH:/usr/local/opt/mongodb/bin/mongoexport"
PATH="$PATH:$GOPATH/bin";
PATH="$PATH:$HOME/scripts/";
PATH="$PATH:$HOME/.scripts/";
PATH="$PATH:$HOME/git-extra-commands/bin/";
PATH="$PATH:/usr/local/Cellar/node/11.6.0/bin/";
PATH="$PATH:$HOME/.scarf/bin/";
#PATH="$PYENV_ROOT/bin:$PATH"
export PATH;

# Pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#eval "$(pyenv init -)"

export NOTES_CLI_HOME="$HOME/Remote/notes";
eval "$(notes --completion-script-bash)";

export CHEAT_USE_FZF=true;

eval "$(/opt/homebrew/bin/thefuck --alias)";
#complete -W "$(teamocil --list)" teamocil;
stty erase '^?';

# Move next only if `homebrew` is installed
if command -v /opt/homebrew/bin/brew >/dev/null 2>&1; then #
    # Load rupa's z if installed
    [ -f "$(/opt/homebrew/bin/brew --prefix)/etc/profile.d/z.sh" ] && source "$(/opt/homebrew/bin/brew --prefix)/etc/profile.d/z.sh";
fi #

if [ -f "$(/opt/homebrew/bin/brew --prefix)/etc/bash_completion" ]; then #
. "$(/opt/homebrew/bin/brew --prefix)/etc/bash_completion";
fi #

if [ -f "$(/opt/homebrew/bin/brew --prefix)/etc/bash_completion.d/git-completion.bash" ]; then #
    . "$(/opt/homebrew/bin/brew --prefix)/etc/bash_completion.d/git-completion.bash";
fi #

source gtm-plugin.sh;
#source ~/codechecker/venv/bin/activate

eval "$(/opt/homebrew/bin/brew shellenv)";
source ~/.bash_functions;
source ~/.bash_functions_strings;
source ~/.bash_profile_work;
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
# eval "$(starship init bash)";
