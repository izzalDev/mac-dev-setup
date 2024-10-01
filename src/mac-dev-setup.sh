#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print messages with a marker
print_marker() {
    echo "=== $1 ==="
}

# MARK: HOMEBREW
print_marker "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
sudo softwareupdate --install-rosetta --agree-to-license

# MARK: DEVELOPMENT TOOLS
print_marker "Installing Development Tools"
brew install git gh tree kotlin gradle flutter node cocoapods mas

# MARK: JAVA
print_marker "Installing Java"
brew install java
sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
echo 'export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# MARK: CONDA
print_marker "Installing Miniconda"
brew install miniconda
conda init zsh
source ~/.zshrc

# MARK: XCODE
print_marker "Installing Xcode"
mas install "$(mas search Xcode | grep -m 1 "Xcode" | awk '{print $1}')"
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license accept
xcodebuild -runFirstLaunch
xcodebuild -downloadPlatform iOS

# MARK: ANDROID SDK
print_marker "Installing Android SDK"
brew install --cask android-commandlinetools

# Set up Android SDK environment variables
echo 'export ANDROID_HOME=$HOME/Library/Android/sdk' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/emulator' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/tools' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/tools/bin' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
source ~/.zshrc

# Accept SDK licenses and install required packages
yes | sdkmanager --licenses
sdkmanager "emulator" \
            "build-tools;34.0.0" \
            "platforms;android-34" \
            "platform-tools" \
            "system-images;android-34;google_apis;arm64-v8a" \
            "sources;android-34"

# Create AVD for Pixel 7
print_marker "Creating AVD for Pixel 7"
avdmanager create avd -n Pixel_7 -k "system-images;android-34;google_apis;arm64-v8a" --device "pixel_7" --force

# MARK: TERMINAL
print_marker "Installing Terminal Applications"
brew install --cask iterm2
brew install starship
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# MARK: APPLICATIONS
print_marker "Installing Applications"
brew install --cask font-jetbrains-mono arc iina rectangle telegram whatsapp postman microsoft-office visual-studio-code docker alt-tab

# MARK: REMOVE MICROSOFT APPS
print_marker "Removing Microsoft Apps"
rm -rf /Applications/Microsoft\ Outlook.app
rm -rf /Applications/Microsoft\ Defender\ Shim.app
rm -rf /Applications/Microsoft\ OneNote.app

print_marker "Installation Complete"
