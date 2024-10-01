#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print messages with a marker
print_marker() {
    echo -e "\033[1;34m===> MARK: $1 <===\033[0m"
}

# Function to add to PATH if not already present
add_to_path() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        echo "Adding $1 to PATH"
        echo "export PATH=\"$1:\$PATH\"" >> ~/.zshrc
    else
        echo "$1 is already in PATH"
    fi
}

# HOMEBREW
print_marker "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
sudo softwareupdate --install-rosetta --agree-to-license

# DEVELOPMENT TOOLS
print_marker "Installing git"
brew install git

print_marker "Installing GitHub CLI"
brew install gh

print_marker "Installing tree"
brew install tree

print_marker "Installing Kotlin"
brew install kotlin

print_marker "Installing Gradle"
brew install gradle

print_marker "Installing Flutter"
brew install flutter

print_marker "Installing Node.js"
brew install node

print_marker "Installing CocoaPods"
brew install cocoapods

print_marker "Installing mas"
brew install mas

# JAVA
print_marker "Installing Java (OpenJDK)"
brew install openjdk

# Create a symlink for OpenJDK
if [[ ! -d "/Library/Java/JavaVirtualMachines/openjdk.jdk" ]]; then
    sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
else
    echo "OpenJDK is already linked."
fi

# Add Java to PATH
add_to_path "/opt/homebrew/opt/openjdk/bin"
source ~/.zshrc

# CONDA
print_marker "Installing Miniconda"
brew install miniconda
conda init zsh
source ~/.zshrc

# XCODE
print_marker "Installing Xcode"
mas install "$(mas search Xcode | grep -m 1 "Xcode" | awk '{print $1}')"
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license accept
xcodebuild -runFirstLaunch
xcodebuild -downloadPlatform iOS

# ANDROID SDK
print_marker "Installing Android Command Line Tools"
brew install android-commandlinetools
add_to_path "$HOME/Library/Android/sdk/emulator"
add_to_path "$HOME/Library/Android/sdk/tools"
add_to_path "$HOME/Library/Android/sdk/tools/bin"
add_to_path "$HOME/Library/Android/sdk/platform-tools"
source ~/.zshrc
yes | sdkmanager --licenses
sdkmanager "emulator" \
            "build-tools;34.0.0" \
            "platforms;android-34" \
            "platform-tools" \
            "system-images;android-34;google_apis;arm64-v8a" \
            "sources;android-34"

# CREATING AVD
print_marker "Creating AVD for Pixel 7"
avdmanager create avd -n Pixel_7 -k "system-images;android-34;google_apis;arm64-v8a" --device "pixel_7" --skin "pixel_7a"

# TERMINAL
print_marker "Installing iTerm2"
brew install --cask iterm2

print_marker "Installing Starship"
brew install starship
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# APPLICATIONS
print_marker "Installing JetBrains Mono font"
brew install --cask font-jetbrains-mono

print_marker "Installing Arc Browser"
brew install --cask arc

print_marker "Installing IINA media player"
brew install --cask iina

print_marker "Installing Rectangle"
brew install --cask rectangle

print_marker "Installing Telegram"
brew install --cask telegram

print_marker "Installing WhatsApp"
brew install --cask whatsapp

print_marker "Installing Postman"
brew install --cask postman

print_marker "Installing Microsoft Office"
brew install --cask microsoft-office

print_marker "Installing Visual Studio Code"
brew install --cask visual-studio-code

print_marker "Installing Docker"
brew install --cask docker

print_marker "Installing Alt-Tab"
brew install --cask alt-tab

# REMOVING MICROSOFT APPS
print_marker "Removing Microsoft Outlook"
rm -rf /Applications/Microsoft\ Outlook.app

print_marker "Removing Microsoft Defender Shim"
rm -rf /Applications/Microsoft\ Defender\ Shim.app

print_marker "Removing Microsoft OneNote"
rm -rf /Applications/Microsoft\ OneNote.app

print_marker "Installation Complete"
