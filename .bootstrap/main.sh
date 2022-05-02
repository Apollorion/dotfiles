#!/bin/bash

# Install brew stuff
cd ~
brew bundle install
cd -

# Install OHMYZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set default applications for file types
duti -s com.sublimetext.4 .md all
duti -s com.sublimetext.4 .txt all
duti -s com.sublimetext.4 .yaml all
duti -s com.sublimetext.4 .yml all

# Install / configure asdf plugins
asdf plugin add awscli
asdf plugin add golang
asdf plugin add kubectl
asdf plugin add terraform
asdf plugin add nodejs
asdf plugin add yarn

asdf install awscli latest
asdf install golang latest
asdf install kubectl latest
asdf install terraform latest
asdf install nodejs latest
asdf install yarn latest

# NPM
npm install --global expo-cli

# Copy secrets template if none exist
if [ ! -f ~/secrets.sh ]; then
    cp ~/secret_template.sh ~/secrets.sh
fi

# OSX defaults
defaults -currentHost write com.apple.dock tilesize -float 36 # Sets dock size
defaults -currentHost write com.apple.dock show-recents -bool false # Disable recents in the dock
defaults -currentHost write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2 # Right click with bottom right corner of trackpad
defaults -currentHost write -g com.apple.swipescrolldirection -bool false # Disable natural scroll direction
defaults -currentHost write -g com.apple.mouse.scaling -float 20.0 # Speed up the mouse
