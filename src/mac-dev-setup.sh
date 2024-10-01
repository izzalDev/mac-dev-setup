#!/bin/bash

# MARK: HOMEBREW
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
sudo softwareupdate --install-rosetta --agree-to-license

# MARK: DEVELOPMENT TOOLS
brew install git
brew install gh
brew install tree
brew install kotlin
brew install gradle
brew install flutter
brew install node
brew install cocoapods
brew install mas

# MARK: JAVA
brew install java
sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
echo 'export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"' >> $HOME/.zshrc
source ~/.zshrc

# MARK: CONDA
brew install miniconda
conda init zsh
source ~/.zshrc

# MARK: XCODE
mas install $(mas search Xcode | grep -m 1 "Xcode" | awk '{print $1}')
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license accept
xcodebuild -runFirstLaunch
xcodebuild -downloadPlatform iOS

# MARK: ANDROID SDK
brew install android-commandlinetools
echo 'export PATH=$PATH:$ANDROID_HOME/emulator' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/tools' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/tools/bin' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
source ~/.zshrc
yes | sdkmanager --licenses
sdkmanager "emulator" \
            "build-tools;34.0.0" \
            "platforms;android-34" \
            "platform-tools" \
            "system-images;android-34;google_apis;arm64-v8a" \
            "sources;android-34"
avdmanager avdmanager create avd -n Pixel_7 -k "system-images;android-34;google_apis;arm64-v8a" --device "pixel_7" --skin "pixel_7"

# MARK: TERMINAL
brew install --cask iterm2
brew install starship
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# MARK: APPLICATIONS
brew install --cask font-jetbrains-mono
brew install --cask arc
brew install --cask inna
brew install --cask rectangle
brew install --cask telegram
brew install --cask whatsapp
brew install --cask postman
brew install --cask microsoft-office
brew install --cask visual-studio-code
brew install --cask docker
brew install --cask alt-tab

# MARK: REMOVE MICROSOFT APPS
rm -rf /Applications/Microsoft\ Outlook.app
rm -rf /Applications/Microsoft\ Defender\ Shim.app
rm -rf /Applications/Microsoft\ OneNote.app
