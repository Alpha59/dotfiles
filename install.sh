ln -s ${PWD##*/}/.vimrc $HOME/.vimrc;
ln -s ${PWD##*/}/.bash_profile $HOME/.bash_profile;

mkdir ~/Dev
chmod +x $HOME/scripts/*

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
brew -v;
brew install node;
node -v;
npm -v;
npm install -g n;

brew update;
brew tap caskroom/cask;
brew install python;
brew install neovim;
brew install vim --with-override-system-vi;
brew install thefuck;
brew install git-standup;

pip install --upgrade pip;

brew install caskroom/cask/brew-cask;
brew cask install firefox;
brew cask install hyper;
brew cask install beardedspice;
brew cask install google-chrome;
brew cask install slack;

infect-vim tpope vim-pathogen;
infect-vim maralla completor.vim;
infect-vim editorconfig editorconfig-vim;
infect-vim itchyny lightline.vim;
infect-vim scrooloose nerdtree;
infect-vim vim-syntastic syntastic;
infect-vim tpope vim-fugitive;
infect-vim terryma vim-multiple-cursors;
infect-vim dhruvasagar vim-table-mode;

git clone git@github.com:unixorn/git-extra-commands.git

npm install --global trash-cli;

npm install --global speed-test;

npm install -g vtop;

npm install --global public-ip-cli;

npm install --global dev-time-cli;

npm install http-server -g;

npm install -g live-server;

npm install --global fkill-cli;

npm install --global kill-tabs;

npm i -g pen;

npm install gtop -g;

npm install -g dockly;

npm install uber-cli -g;

npm install -g trashss;

brew install exa;

brew install fpp;

pip install maybe;

curl https://raw.githubusercontent.com/kcrawford/dockutil/master/scripts/dockutil >> ~/scripts/dockutil;
chmod +x ~/scripts/dockutil;
dockutil --remove Maps;
dockutil --remove Facetime;
dockutil --remove FaceTime;
dockutil --remove iTunes;
dockutil --remove Calendar;
dockutil --remove Launchpad;

cd /Applications && curl http://www.ninjamonkeysoftware.com/slate/versions/slate-latest.tar.gz | tar -xz; cd ~;
open /Applications/Slate.app
brew install badtouch;

brew install chrome-cli;

brew install cig;

brew install ccat;

brew install defaultbrowser;
defaultbrowser chrome;
brew install doitlive;

brew install genact;

brew install tmux;

brew install hub;

brew install icdiff;

brew install kommit;

brew install porti;

brew install noti;

brew install pipes-sh;

brew install sl;

brew install slackcat;

npm install spoof -g;

brew install jid;

brew tap git-time-metric/gtm;

brew install gtm;

pip install black;

bash ./macos.sh;

brew install git bash-completion;

npm install --global status-git;

brew install mas;

brew tap wagoodman/dive;

brew install dive;

wget -qO- https://get.haskellstack.org/ | sh

stack install toodles;

yarn global add pwmetrics;

pip install howdoi;

mkdir ~/.weechat/
mkdir ~/.weechat/python
mkdir ~/.weechat/python/autoload

brew install weechat --with-python@2

sudo /usr/local/opt/python@2/bin/pip2 install websocket_client

wget https://weechat.org/files/scripts/leet.py
mv leet.py ~/.weechat/python/autoload

wget https://raw.githubusercontent.com/wee-slack/wee-slack/master/wee_slack.py
mv wee_slack.py ~/.weechat/python/autoload
brew install jumbo-john;

brew install john-jumbo;

brew install nmap;

brew install bash-completion;

brew install calc;

brew install speedtest_cli;

brew install darkmode;

brew install dark-mode;

brew install z;

brew install tldr;

brew install cmatrix;

brew install spoof-mac;

curl https://www.teleconsole.com/get.sh | sh;

brew cask install java;

brew install ninja-dev-sync;

brew cask install macdown;

brew cask install mtmr;

gem install teamocil;

brew install yes;

brew install gti;

brew install archey;

brew install wdiff;

brew install dshb;

brew install tree;

brew cask install caffeine;

brew install wget;

brew cask install ponysay;
