ln -s ${PWD##*/}/.vimrc $HOME/.vimrc;
ln -s ${PWD##*/}/.bash_profile $HOME/.bash_profile;

mkdir ~/Dev
chmod +x $HOME/scripts/*

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py

brew -v;
brew install node;
node -v;
npm -v;
npm install -g n;

brew update;
brew tap caskroom/cask;
brew tap homebrew/cask-cask;
brew tap caskroom/cask
brew install python;
brew install neovim;
brew install vim;
brew install thefuck;
brew install git-standup;

pip install --upgrade pip;

brew install caskroom/cask/brew-cask;
brew install --cask firefox;
brew install --cask hyper;
brew install --cask beardedspice;
brew install --cask google-chrome;
brew install --cask slack;

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

#brew install porti;

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
#brew install jumbo-john;

brew install john-jumbo;

brew install nmap;

brew install bash-completion;

brew install calc;

brew install speedtest_cli;

#brew install darkmode;

brew install dark-mode;

brew install z;

brew install tldr;

brew install cmatrix;

brew install spoof-mac;

curl https://www.teleconsole.com/get.sh | sh;

brew install --cask java;

#brew install ninja-dev-sync;

brew install --cask macdown;

brew install --cask mtmr;
mv items.json /Users/ailor/Library/Application\ Support/MTMR/items.json; # Update the MTMR preferences file

#brew install yes;

brew install gti;

brew install archey;

brew install wdiff;

brew install dshb;

brew install tree;

brew install --cask caffeine;

brew install wget;

#brew cask install ponysay;
brew install --cask ponysay;
brew install gpg;

gpg --default-new-key-algo rsa4096 --gen-key;

brew install blackbox;

brew install bat;

brew install entr;

brew install youtube-dl;

pip install flake8;

npm install eslint;

npm install -g eslint;

npm install eslint-config-react-app;

npm install -g eslint-config-react-app;

npm install -g eslint-plugin-import;

npm install -g eslint-plugin-flowtype;

npm install -g eslint-plugin-jsx-a11y;

npm install -g eslint-plugin-react;

npm install -g babel-eslint;

npm install -g pretty-diff;

npm install -g diff2html;

npm install -g diff2html-cli;

npm install -g node-giff;

infect-vim mxw vim-jsx;

brew install bluetoothconnector;

brew install minicom;

brew install postgresql;

brew install john-jumbo;

gem install teamocil;

source .bash_profile;

exec -l $SHELL;
brew install aspell;

brew cask install docker;

brew install docker;

softwareupdate --install-rosetta;

npm install nunjucks;

brew install xelatex;

npm install nunjucks-cli -g;

brew install texlive-xetex;

brew install pandoc basictex xelatex;

brew install pandoc;

brew install basictex;

curl -L https://scarf.sh/install;

/Users/ailor/.scarf/bin/scarf install toodles;

brew install expect;

brew install autoexpect;

brew install expect;

pip install python-yubico;

sudo port install libusb;

port install libusb;

brew install libusb;

brew install libusb-compat;

pip install PyUSB;

pip install pyusb;

mas signin;

mas upgrade;
mas install 1003160018 # Quip (7.73.0);
mas install 1474276998 # HP Smart (12.7.1)
mas install 405399194 # Kindle (1.31.0)
mas install 1340501510 # Ora (3.1.7)
mas install 937984704 # Amphetamine (5.2.2)
# mas install 408981434 # iMovie (10.2.4)
mas install 409201541 # Pages (11.1)
# mas install 682658836 # GarageBand (10.3.5)
mas install 409183694 # Keynote (11.1)
mas install 803453959 # Slack (4.17.0)
mas install 1497527363 # Blurred (1.2.0)
mas install 409203825 # Numbers (11.1)
mas install 1534275760  #LanguageTool - Grammar Checker (1.2.3)


brew install wifi-password;

brew install calc;

brew install jq;

sudo -H pip install -U oletools;

brew install pandoc;

brew install bash-completion;

brew install pmd;

brew install spotbugs;

brew install graphviz;

npm install -g cdk-dia;

npm i -g trash-cli;

brew install testdisk;

brew install dos2unix;

brew install flake8;

brew install clang-format;

brew install pre-commit;

brew install ykman;

brew install diff2html;

npm -g install diff2html;

npm install -g diff2html-cli;

brew install aws-sam-cli-beta-cdk;

brew install rlwrap;

npm i newman;

npm i -g newman;

brew install libfido2;

brew install libusb;

pip3 install onlykey;

brew install ddcctl;

open https://github.com/pqrs-org/Karabiner-Elements/releases/download/v14.11.0/Karabiner-Elements-14.11.0.dmg;
