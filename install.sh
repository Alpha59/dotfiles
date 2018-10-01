ln -s ${PWD##*/}/.vimrc $HOME/.vimrc;
ln -s ${PWD##*/}/.bash_profile $HOME/.bash_profile;

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
brew -v;
brew install node;
node -v;
npm -v;
npm install n;
brew update;
brew tap caskroom/cask;
brew install python;
brew install neovim;
brew cask install firefox;
brew cask install hyper;
brew cask install google-chrome;

chmod +x $HOME/scripts/*
