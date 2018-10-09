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
brew install slack;
brew install git-standup;

brew install caskroom/cask/brew-cask;
brew cask install firefox;
brew cask install hyper;
brew cask install beardedspice;
brew cask install google-chrome;

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

