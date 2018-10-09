alias sudo='sudo '
alias ls='exa -l '
alias bc='bc -l '
alias dammit='docker-compose down; docker-compose up -d '
alias sudo=' '
alias fucking='\sudo '
alias fucking!='fucking !! '
alias startUp='npm run start-dev '
alias simpleserver='Python -m SimpleHTTPServer '
alias clear='clear;clear;clear;clear;clear;clear;clear;clear; '
alias lynx='lynx -accept_all_cookies '
alias cvim='charm '
# alias vim='nvim '
alias keyadd='ssh-add -K ~/.ssh/ '
alias autopep='autopep8 -i -r -a -a '
alias mongos='mongodb --dbpath /usr/local/data/db/ '
alias scenario='python ./tests/unit/engines/promotion/scenarios/promotion_scenarios_tests.py '
alias note='jrnl '
alias rm='trash '
alias top='vtop '
alias weather='curl wttr.in/philadelphia'
export PS1="\t:\w>Yes Jake? >> "

set -o vi

export PATH=$PATH:/usr/local/opt/mongodb/bin/mongoexport:$GOPATH/bin:$HOME/scripts/:$HOME/git-extra-commands/bin/

export UCAT_ORACLE_SID=ATGUTL
export UCAT_ORACLE_SERVICE=dev_mcp_phl_svc
export UCAT_ORACLE_USERNAME=MCPDEV_3
export UCAT_ORACLE_PASSWORD=MCPDEV_3
export UCAT_ORACLE_HOST=10.9.28.100
export UCAT_ORACLE_PORT=1531
export GOPATH=/Users/ailorj1/Dev/go/
export GOCATSS_ELASTIC_URL=35.196.48.157;GOCATSS_ELASTIC_PORT=8080;GOCATSS_ENVIRONMENT=DEV;GOCATSS_MONGO_HOST=;GOCATSS_MONGO_DATABASE=;GOCATSS_TOKEN_SIGNING_SECRET=;GOCATSS_JWT_PAYLOAD_KEY=
# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH:$HOME/scripts/"
eval "$(pyenv init -)"
