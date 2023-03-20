#!/bin/bash

# Install brew stuff
cd ~
brew bundle install
cd -

# Install OHMYZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Easy K8s Secrets
cd ~
git clone https://github.com/Apollorion/easy-k8s-secrets.git
cd -

# Set default applications for file types
duti -s com.sublimetext.4 .md all
duti -s com.sublimetext.4 .txt all
duti -s com.sublimetext.4 .yaml all
duti -s com.sublimetext.4 .yml all
duti -s com.sublimetext.4 .sh all
duti -s com.sublimetext.4 .js all

# Install / configure asdf plugins
asdf plugin add awscli
asdf plugin add golang
asdf plugin add kubectl
asdf plugin add terraform
asdf plugin add nodejs
asdf plugin add yarn
asdf plugin add python
asdf plugin add ruby

asdf install awscli 2.4.9
asdf install golang 1.17.6
asdf install kubectl 1.23.1
asdf install terraform 1.1.7
asdf install nodejs 16.13.2
asdf install yarn 1.22.17
asdf install python 3.10.5
asdf install ruby 3.1.2

asdf global awscli 2.4.9
asdf global golang 1.17.6
asdf global kubectl 1.23.1
asdf global terraform 1.1.7
asdf global nodejs 16.13.2
asdf global yarn 1.22.17
asdf global python 3.10.5
asdf global ruby 3.1.2

# always install nodejs 16.13.2 all the NPM installs below require it.
# asdf install nodejs 16.13.2

# NPM
ASDF_NODEJS_VERSION="16.13.2" npm install --global expo-cli commitizen cz-customizable

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

# GPG Things
launchctl load gnupg.gpg-agent.plist
launchctl load gnupg.gpg-agent-symlink.plist
