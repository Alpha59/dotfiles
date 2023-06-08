#!/bin/bash;

#shellcheck -x;

# Broken or Removed
    #brew install ninja-dev-sync;
    #brew install porti;
    #brew install aws-sam-cli-beta-cdk;
    #brew install aws;
    #brew install badtouch;
    #brew install basictex;
    #brew install dshb;
    #brew install gpg;
    # CLI slack interactions (not authorized)
    #brew install slackcat;
    #sudo -H pip install -U oletools;
    #sudo /usr/local/opt/python@2/bin/pip2 install websocket_client;
    #sudo port install libusb;
    #wget -qO- https://get.haskellstack.org/ | sh;
    #yarn global add pwmetrics;
    # Install weechat slack
    # Not supported as Plugin
    #mkdir ~/.weechat/;
    #export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES;
    #wget https://raw.githubusercontent.com/wee-slack/wee-slack/master/wee_slack.py;
    #wget https://weechat.org/files/scripts/leet.py;
    #mv leet.py ~/.weechat/python/autoload;
    #mv wee_slack.py ~/.weechat/python/autoload;
    # uber lookup, not working
    #npm install -g uber-cli;
    #pip3 install onlykey;

# Close any open System Preferences panes, to prevent them from overriding
# # settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

toolbox;

# Ask for the administrator password upfront
sudo -v

xcode-select --install;
softwareupdate --install-rosetta;

# Collect passwords for use later
echo "ENTER COMPUTER PASSWORD";
read -r PASSWORD;
security add-generic-password -a "$USER" -s amzn_mac -w "$PASSWORD" -U
echo "ENTER TOKEN KEY";

read -r PASSWORD;
security add-generic-password -a "$USER" -s amzn_vpn -w "$PASSWORD" -U;
sudo chown -R $USER ~/.ssh;
chmod 700 ~/.ssh;
brew install --cask macvim;
brew install python;
git config --global user.email "$USER@amazon.com";

ssh-keygen -t ecdsa -C "$USER@amazon.com";
kinit && mwinit -k ~/.ssh/id_ecdsa.pub;
kinit -f && mwinit -s -o --aea;
# Install Homebrew if it isn't working
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)";
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> "$HOME/.bash_profile";
eval "$(/opt/homebrew/bin/brew shellenv)";
echo "wait until homebrew install complete";
read -r;
rm "$HOME/Remote";

brew tap amazon/homebrew-amazon ssh://git.amazon.com/pkg/HomebrewAmazon;
brew analytics off;
brew install ruby;

# Make my scripts executable
chmod +x "$HOME"/scripts/*;

# Get the latest version of slate;
# a window manager with keyboard shortcuts
# configured in .slate
open https://github.com/jigish/slate/raw/master/build/Release/Slate.dmg;
open /Applications/Slate.app;

brew install python;
brew install node;
pip install --upgrade pip;

mv ~/MTMR/items.json "$HOME/Library/Application Support/MTMR/items.json"; # Update the MTMR preferences file
open https://github.com/pqrs-org/Karabiner-Elements/releases/download/v14.11.0/Karabiner-Elements-14.11.0.dmg;

# Install Global Python Modules
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py;
python get-pip.py;
mkdir ~/Dev;

# Install Global NPM modules
node -v;
npm -v;

# Install Mac software from Store
brew install mas;
mas signin;
mas upgrade;
# Install Ora, a Project management tool
mas install 1340501510 # Ora (3.1.7)

# Install HP Smart - to enable my printer
mas install 1474276998 # HP Smart (12.7.1)

# Install Blurred - which blacks out windows not currently in use.
mas install 1497527363 # Blurred (1.2.0)
brew install --cask blurred;

# Language and Grammer Checker
mas install 1534275760  #LanguageTool - Grammar Checker (1.2.3)

mas install 405399194 # Kindle (1.31.0)
mas install 409183694 # Keynote (11.1)
mas install 409201541 # Pages (11.1)
mas install 409203825 # Numbers (11.1)
mas install 803453959 # Slack (4.17.0)
#mas install 1003160018 # Quip (7.73.0);

# Install Amphetamine, a program to keep your
# computer awake while connected to VPN
mas install 937984704 # Amphetamine (5.2.2)

# Install Bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
bash ./macos.sh;
brew -v;
brew update;

# Tap casks - although I am not sure this is required anymore
brew install caskroom/cask/brew-cask;
brew install lotyp/formulae/dockutil;
brew tap caskroom/cask;
brew tap git-time-metric/gtm;
brew tap homebrew/cask-cask;
brew tap wagoodman/dive;
brew tap teamookla/speedtest;
python3 -c "$(curl -fsS https://m.media-amazon.com/images/G/01/homebrew/bootstrap.py)";
brew tap amzn/amzn;

# Command Line Improvements
    brew install bash-completion;

    # Colored Output
    # Bat is scrolling
    # Ccat is not
    brew install bat;
    brew install ccat;

    # Simple documentation
    # for some things...
    brew install tldr;
    # Custom documentation for local things
    # Prints the information under /.cheat/<command>
    # when asking for cheat <command>
    # A simple util for storing information
    # This can be used outside of just bash commands
    brew install cheat;

    # just a better version of ls
    # This is used in an alias
    brew install exa;
    # interactive file browser
    # Just run fpp
    brew install fpp;

    # adds up/down to interactive commands
    brew install rlwrap;

    # Java Analysis
    brew install spotbugs;

    # Run things in mini containers
    brew install tmux;
    brew install tree;
    brew install vim;
    brew install wget;
    brew install z;

    # Move things to trash instead of
    # deleting permenently
    npm install -g trash-cli;

    # ask questions of your cli
    pip install howdoi;

# Language Formatters/linters
    # A tool to format C/C++/Java/JavaScript/JSON/Objective-C/Protobuf/C# code.
    # This is used in various checks throughout other scripts
    brew install clang-format;
    # Static Code analyser
    brew install pmd;
    # Linter for Bash
    brew install shellcheck;

    # Python Formatter
    brew install flake8;
    npm install -g babel-eslint;
    npm install -g eslint-config-react-app;
    npm install -g eslint-plugin-flowtype;
    npm install -g eslint-plugin-import;
    npm install -g eslint-plugin-jsx-a11y;
    npm install -g eslint-plugin-react;
    npm install -g eslint;
    pip install black;
    pip install flake8;

# Informational tools
    # Script to display System information
    brew install archey4;

    # Shows bluetooth connections and allows you to
    # Connect / Disconnect via CLI
    brew install bluetoothconnector;

# GIT Additional stuffs:
    # Displays all of the statuses for
    # Git repositories - recursive
    # (S)taged, (M)odified, (N)ew, (P)ush
    brew install cig;
    brew install git-standup;

    # replaces mistyped git as gti with an
    # old gti running across the screen
    brew install gti;
    # Productivity Tracker
    brew tap git-time-metric/gtm;
    brew install gtm;

    # github CLI
    brew install hub;

    # Pretty Differ
    brew install icdiff;
    # Allows you to run `git kommit -m ''` to append
    # information to your git commit without actually
    # committing.
    # Good for note taking
    brew install kommit;

    # Framework for managing multi-language pre-commit hooks
    brew install pre-commit;

    # Colorized diff in HTML
    # diff2html -- HEAD~1
    brew install diff2html;
    npm install -g diff2html;
    npm install -g diff2html-cli;
    npm install -g node-giff;
    npm install -g pretty-diff;
    npm install -g trashss;

# Just for fun:
    # Text based web browser
    brew install links;
    # Colorful large text
    brew install toilet;
    # Speak in a robot voice
    brew install espeak;
    # Just a cool tool to show the matrix in the CLI
    brew install cmatrix;
    # Creates random output to look busy
    brew install genact;
    # Shows old pipes screensaver
    # run with pipes.sh
    brew install pipes-sh;
    # Shows a steam locomotive
    brew install sl;
    # Runs a speed test of the internet
    brew install speedtest;
    # Fix errors in shell commands
    brew install thefuck;

    # Stock Ticker
    brew install achannarasappa/tap/ticker;

    # Monitor how many people are around on the wifi
    ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport;
    brew install wireshark;
    pip install howmanypeoplearearound;

    # A tool to allow you to live type
    # commands during a demo and actually
    # run them... which is so cool;
    brew install doitlive;
    # Extensible IRC client
    # Slack is blocked here
    brew install weechat;
    brew install cowsay;
    # Gets the time for any github user
    npm install -g dev-time-cli;

    # Gets a random quote from the internet
    brew install fortune;

# Mac Settings Tools
    # Tool to help manage the mac dock
    brew tap lotyp/homebrew-formulae;

    # Remove certain applications from being ever present in the Dock
    dockutil --remove Calendar;
    dockutil --remove FaceTime;
    dockutil --remove Launchpad;
    dockutil --remove Maps;
    dockutil --remove iTunes;

    # CLIT tool to toggle dark-mode
    brew install dark-mode;
    brew install defaultbrowser;
    brew install --cask docker;
    # A tool to utilize the mac media tools
    brew install --cask beardedspice;

    # Tool to keep the computer screen on
    brew install --cask caffeine;
    brew install --cask firefox;
    brew install --cask google-chrome;

    # Terminal with slightly better UI
    brew install --cask hyper;
    brew install --cask java;

    # Notes app for markdown
    brew install --cask macdown;

    # Touchbar controller
    brew install --cask mtmr;
    brew install --cask slack;

    brew install tccutil;

    # Set some settings;
    defaultbrowser chrome;

# Some USB and Network Tools
    brew install libfido2;
    brew install libusb-compat;
    brew install libusb;
    brew install minicom;
    brew install nmap;
    brew install ykman;
    pip install PyUSB;
    pip install python-yubico;
    pip install pyusb;
    port install libusb;

# Pandoc / LATEX stuff
    brew install pandoc basictex xelatex;
    brew install pandoc;
    brew install texlive-xetex;
    brew install xelatex;
# Trackers
    # Simple clockin/clockout tool
    npm install -g moro;
# Utilities
    # Warp Terminal
    brew install --cask warp;

    # Interactive CLI app builder
    brew install gum;

    # Mac application shortcuts
    brew install m-cli;
    # File space manager
    brew install dua-cli;
    brew install calc;

    # Simple encrypt local files
    brew install blackbox;
    brew install chrome-cli;

    # Convert file formats
    brew install dos2unix;
    # JSON filter / prettifier
    brew install jq;
    # interactive JQ
    brew install jid;

    # Run before any command to get a notification when that
    # Command has completed
    # Very useful for long running commands in the background
    brew install noti;

    # Scripting Language Tool for
    # Guessing input to a file
    # spawn ssh $env(DESK)
    # expect -re "PIN for $my_user:"
    # send -- "$my_password\r"
    brew install expect;

    # Rerun a command when files change
    # This is useful for simple things
    # ls filename | entr -s '<command>'
    brew install entr;
    # Tools to work with disk recovery
    brew install testdisk;

    # Open Souce Spreadsheet application.
    # It's helpful for quick processing of values
    # Mapped as the alias csv
    # very easy quick way to view CSV files
    brew install gnumeric;

    # Convert specific text into Graphical format
    brew install graphviz;

    # Password Cracker
    brew install john-jumbo;

    # Keep doing something until
    # there is a successful or errored output
    brew install watch;
    brew install wifi-password;

    # Easily change mac-address
    brew install spoof-mac;

    # Force kill triggered with fkill
    npm install -g fkill-cli;
    # Hot reloading server
    npm install -g live-server;
    npm install -g http-server;

    # Visual of what's running
    npm install -g vtop;
    npm install -g gtop;

    # Tells you what a program will
    # do before running it.
    #pip install maybe;

    # used to convert xlsx2csv
    # xlsx2csv -ai
    pip install xlsx2csv;

    # Record terminal activity to share later;
    brew install asciinema;

    # CLI SQL:
    brew install mysql-client;
    # A much better SQL client
    brew install mycli;

    # Share your terminal via web or ssh
    brew install tmate;
    pip install rebound-cli;

    # Markdown viewer in the terminal
    brew install glow;

    # Web search from terminal
    brew install s-search;

    # Daily News
    npm install -g newsroom-cli;

    curl https://i.jpillora.com/Nemoden/gogpt! | bash;
    open https://platform.openai.com/account/api-keys;
    gogpt config;

    # AMZN
    # Sync processes between a server and a mac
    brew install ninja-dev-sync

    # https://w.amazon.com/bin/view/IonCpp/Cookbook#Command_Line_Utilities
    brew install ionist;

    # Customize the prompt
    brew install starship

# Text Processing
    # Install some Depdendencies
    #
    # Spell Checker for CLI
    # runs with aspell -c <filename>
    brew install aspell;
    brew install proselint;
    npm install -g alex;

    # Show word differences between 2 text files
    # Aliased to `diff-txt` to get some color via
    # ccat
    brew install wdiff;

# Other... random?
    brew install youtube-dl;
    # Container Management tool
    npm install -g dockly;

    brew install docker;
    # Allows inspection of Docker images
    brew install dive;
    # VIM upgraded
    brew install neovim;

    open "https://keepass.info/download.html";

# Update Brew again.
brew update;

# Generate a gpg key
#gpg --default-new-key-algo rsa4096 --gen-key;

# Infect VIM
    # Install Pathogen
    mkdir -p ~/.vim/autoload ~/.vim/bundle &&;
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    #curl -LSso ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim;
    # Infects vim with pathogen
    infect-vim tpope vim-pathogen;
    # Creates tables as you type <C-p>
    infect-vim dhruvasagar vim-table-mode;
    # Sets editor defaults for multi-person consistency
    infect-vim editorconfig editorconfig-vim;
    # Adds the colorful information at the bottom
    # of vim so that ou know line/char/mode/file/etc
    infect-vim itchyny lightline.vim;

    # Adds the handy little code completer
    infect-vim maralla completor.vim;
    # Searches the:
        # local file / current buffer
        # File Path
        # Bash path
        # Adds support for items in completor_shell#shell_commands
        infect-vim tokorom completor-shell;
        # Adds support for neoinclude
        infect-vim Shougo neocomplete.vim;
        infect-vim Shougo neoinclude.vim;
        infect-vim maralla completor-neosnippet;
        # more here: https://github.com/maralla/completor.vim
    infect-vim mxw vim-jsx;
    infect-vim scrooloose nerdtree;
    # Multiple cursors using <C-n>
    infect-vim terryma vim-multiple-cursors;
    # :Git status; adds git functionality into vim
    infect-vim tpope vim-fugitive;
    # Adds syntax highlighting
    infect-vim vim-syntastic syntastic;

# Insert symlinks for some important things
ln -s "${PWD##*/}/.bash_profile" "$HOME/.bash_profile";
ln -s "${PWD##*/}/.vimrc" "$HOME/.vimrc";
ln -sh "$HOME/Library/CloudStorage/WorkDocsDrive-Documents/" "$HOME/Remote";
ln -sh "$HOME/Library/CloudStorage/WorkDocsDrive-Documents/Hidden/.scripts" "$HOME/.scripts";
ln -sh "$HOME/Library/CloudStorage/WorkDocsDrive-Documents/Hidden/.bash_profile_work" "$HOME/.bash_profile_work";
ln -sh "$HOME/Library/CloudStorage/WorkDocsDrive-Documents/Hidden/.gitmessage" "$HOME/.gitmessage";
rm -rf "$HOME/Downloads";
ln -sh "$HOME/Library/CloudStorage/WorkDocsDrive-Documents/Downloads" "$HOME/Downloads";


# command line postman!
npm install -g newman;

# Markdown editro that allows you to write
# in VIM/terminal and then view it at localhost:6060
npm install -g pen;

# Kill all chrome tabs
npm install -g kill-tabs;
npm install -g public-ip-cli;

# Shows a CDK infrastructure diagram!
# cdk synth; cdk-dia;
npm install -g cdk-dia;
# Manage you node version
npm install -g n;

# Templating library
npm install -g nunjucks-cli;
npm install -g nunjucks;

npm install -g aws-cdk;

# AWS CLI:
curl https://awscli.amazonaws.com/AWSCLIV2.pkg -o AWSCLIV2.pkg;
curl https://www.teleconsole.com/get.sh | sh;
wget https://cachefly.alfredapp.com/Alfred_5.0.6_2110.dmg;
open Alfred_5.0.6_2110.dmg;
killall Finder;

sudo cp ~/com.startup.plist /Library/LaunchDaemons/;
sudo launchctl load -w /Library/LaunchDaemons/com.startup.plist;

echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled > /dev/null 2>&1;
sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled;

# Update apps from the macos Library
sudo softwareupdate -i -a;

defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName;

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40;

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1;
defaults write com.apple.screensaver askForPasswordDelay -int 0;

# More commands / settings can be found here:
# https://macos-defaults.com/#%F0%9F%92%BB-list-of-commands
#
# Create Sensible defaults for settings:
# General Settings
    # Disable press-and-hold for keys in favor of key repeat.
    defaults write -g ApplePressAndHoldEnabled -bool false;

    # Use AirDrop over every interface.
    defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1;

    # Prevent Photos from opening automatically when devices are plugged in
    defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true;

    # Automatically quit printer app once the print jobs complete
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true;

    # Disable the “Are you sure you want to open this application?” dialog
    defaults write com.apple.LaunchServices LSQuarantine -bool false;

    mkdir -p "${HOME}/Remote/Screenshots/";

    # Save screenshots to the Remote directory
    defaults write com.apple.screencapture location -string "${HOME}/Remote/Screenshots/";

    # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
    defaults write com.apple.screencapture type -string "png";

    defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName;

# Finder
    # Always open everything in Finder's list view. This is important.
    defaults write com.apple.Finder FXPreferredViewStyle Nlsv;

    # Set the Finder prefs for showing a few different volumes on the Desktop.
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true;
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true;

    # Finder: show hidden files by default
    defaults write com.apple.finder AppleShowAllFiles -bool true;

    # Finder: show all filename extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true;

    # Finder: show status bar
    defaults write com.apple.finder ShowStatusBar -bool true;

    # Finder: show path bar
    defaults write com.apple.finder ShowPathbar -bool true;

    # Display full POSIX path as Finder window title
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true;

    # Keep folders on top when sorting by name
    defaults write com.apple.finder _FXSortFoldersFirst -bool true;

    # When performing a search, search the current folder by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf";

    # Disable the warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false;

    # Show the /Volumes folder
    sudo chflags nohidden /Volumes;

    # Enable snap-to-grid for icons on the desktop and in other icon views
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist;
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist;
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist;

    # Increase grid spacing for icons on the desktop and in other icon views
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist;
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist;
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist;

# Dock
    # Set the icon size of Dock items to 36 pixels
    defaults write com.apple.dock tilesize -int 36;
    # Enable highlight hover effect for the grid view of a stack (Dock)
    defaults write com.apple.dock mouse-over-hilite-stack -bool true;
    # Enable spring loading for all Dock items
    defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true;

    # Show indicator lights for open applications in the Dock
    defaults write com.apple.dock show-process-indicators -bool true;
    defaults write com.apple.dock persistent-apps -array;

    # Automatically hide and show the Dock
    defaults write com.apple.dock autohide -bool true;
    defaults write com.apple.Dock autohide-delay -float 0;

    # Make Dock icons of hidden applications translucent
    defaults write com.apple.dock showhidden -bool true;

# Safari
    # Set up Safari for development.
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true;
    defaults write com.apple.Safari IncludeDevelopMenu -bool true;
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true;
    defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true;
    defaults write NSGlobalDomain WebKitDeveloperExtras -bool true;

    # Privacy: don’t send search queries to Apple
    defaults write com.apple.Safari UniversalSearchEnabled -bool false;
    defaults write com.apple.Safari SuppressSearchSuggestions -bool true;

    # Set Safari’s home page to `about:blank` for faster loading
    defaults write com.apple.Safari HomePage -string "about:blank";

    # Disable hitting the Backspace key to go to the previous page in history
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool false;

    defaults write com.apple.Safari IncludeInternalDebugMenu 1;

# Trackpad / Keyboard
    # Trackpad: enable tap to click for this user and for the login screen
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true;
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1;
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1;

    # Trackpad: map bottom right corner to right-click
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2;
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true;
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1;
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true;

    # Disable automatic capitalization as it’s annoying when typing code
    defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false;

    # Disable smart dashes as they’re annoying when typing code
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false;

    # Disable automatic period substitution as it’s annoying when typing code
    defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false;

    # Disable smart quotes as they’re annoying when typing code
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false;

    # Disable “natural” (Lion-style) scrolling
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false;

    # Set a blazingly fast keyboard repeat rate
    defaults write NSGlobalDomain KeyRepeat -int 1;
    defaults write NSGlobalDomain InitialKeyRepeat -int 12;

    # Stop iTunes from responding to the keyboard media keys
    launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null;

    # Disable the Launchpad gesture (pinch with thumb and three fingers)
    defaults write com.apple.dock showLaunchpadGestureEnabled -int 0;

    sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist;

    # Enable full keyboard access for all controls
    # (e.g. enable Tab in modal dialogs)
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3;

# Appearance
    sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Welcome back Jake";

    # Enable spring loading for directories
    defaults write NSGlobalDomain com.apple.springing.enabled -bool true;

    # Remove the spring loading delay for directories
    defaults write NSGlobalDomain com.apple.springing.delay -float 0;

    # Change minimize/maximize window effect
    defaults write com.apple.dock mineffect -string "scale";

    # Minimize windows into their application’s icon
    defaults write com.apple.dock minimize-to-application -bool true;

    # Don’t show Dashboard as a Space
    defaults write com.apple.dashboard mcx-disabled -bool true;
    defaults write com.apple.dock dashboard-in-overlay -bool true;

    # Disable the sound effects on boot
    sudo nvram SystemAudioVolume=" ";

    # Increase window resize speed for Cocoa applications
    defaults write NSGlobalDomain NSWindowResizeTime -float 0.001;


killall Dock;

# Update apps from the macos Library
sudo softwareupdate -i -a;

# Accessibility APIs
# sudo tccutil
# This must be run in recovery mode:
# https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection
# csrutil disable
# Run tccutil commands
# then turn off recovery mode.
fucking pmset repeat wake MTWRF 09:00:00;

source "$HOME/.bash_profile";
exec -l "$SHELL";

# eg <command> shows examples of common commands
brew install eg-examples;

# Creates a dictionary of bash commands
# and examples. Needs to be manually populated
pip install ehh;

# Snippet library
# very interactive
brew install nap;

# Interactive tool to
# lookup various commands
brew install navi;

# different sed (GNU sed)
brew install gsed;

# Interactive tool for creating and managing slideshows
# from markdown - supporting pre-processing
brew install slides;
# Slides that support doitlive with the -e terminal
# extension. Same general format as above ^
pip install lookatme;

# View XML Presentations
# These can be very cool, but are very specific to setup:
# https://github.com/yaronn/wopr
npm install -g wopr;

# yaml based report generator to show
# A bunch of information all at once
brew install wtfutil;

# Allows you to look inside git repositories
# on github without leaving the terminal
brew install jarred-sumner/git-peek/git-peek;

# Just tells a joke
pip install pyjokes;

# Doesn't seem to work
pip install matrix-webcam;

# Some more git commands
brew install git-extras;

# Some more git commands
brew link --overwrite git-standup;

# Some more git commands
npm install -g git-commander;

# Automatically moves files around
# Essentially just glob matching though
npm install -g organize-cli;
pip install classifier;

brew install progress;

# Finds duplicate files
brew install rmlint;

# jq style queries on csv files or excel
brew install neilotoole/sq/sq;

# Fuzzy finder
brew install fbeline/luneta/luneta;

# Run multiple commands in parallel with
# interactive split screen to track each
brew install mprocs;

# Network speed test that seems to work
# even on VPN?
npm install --global fast-cli;

# Remove $ at begining of commands pasted from online....
npm install -g undollar;

# Network throughput monitor
brew install bmon;

# terminal based ad blocker for web
# Blocks the websites and prevents them
# from being access at the network card level
brew install hblock;
hblock;

# Looks up where the IP currently in use pings from
# Doesn't work on VPN
npm install -g @rafaelrinaldi/whereami;

# Interactive file browser
brew install fpp;

# Tails multiple files at the same time
brew install multitail;

# Media viewer (mostly for videos)
brew install vlc;

# Notes app that saves notes into git repo
# and can be edited in VIM
# Has several scripts in `~/scripts/notes-*` to enhance functionality
wget https://github.com/rhysd/notes-cli/releases/download/v1.6.2/notes_darwin_amd64.zip;
unzip notes_darwin_amd64.zip;
mv notes ~/scripts/;

# Renames files with 's///g' format
# e.g; `rename 's/_\[\d+m//g' <filename> removes the cli color characters
brew install rename;

brew install bastet;

# Install amazon specific dependencies
brew install clang-format;
brew install aspell;
brew install flake8;
brew install black;
brew install pre-commit;
brew install pmd;
VERSION="0.0.6"
wget https://github.com/inclusivelint/inclusivelint/releases/download/${VERSION}/inclusivelint -O- | tr -d '\r' >inclusivelint
wget https://github.com/inclusivelint/inclusivelint/releases/download/${VERSION}/outputRelation.txt -O- | tr -d '\r' >outputRelation.txt
mv outputRelation.txt ~/.inclusivelint
git config --global core.pager less -FMRiX;
git config --global color.ui auto;
git config --global alias.dag log --graph --format='format:%C(yellow)%h%C(reset) %C(blue)%an <%ae>%C(reset) %C(magenta)%cr%C(reset)%C(auto)%d%C(reset)%n%s' --date-order;
toolbox list | awk '{print $1}' | grep -v -e Run -e === -e --- -e Tool -e ^$ | xargs -n1 toolbox install
brew install timewarrior;
sudo chown $USER .config/homebrew;
sudo chmod 777 .config/homebrew;
sudo chown $USER .config/homebrew/*;
sudo chmod 777 .config/homebrew/*;
brew tap jakehilborn/jakehilborn;

brew install displayplacer;

brew install dos2nix;

brew install dos2unix;

brew install golang;
go install github.com/paij0se/cligpt@latest;
