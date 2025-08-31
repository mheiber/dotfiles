#!/bin/bash

# =============================================================================
# macOS New Computer Setup Script
# =============================================================================
# This script configures a new macOS computer with personal defaults.
# Run with: bash setup-new-mac.sh
#
# IMPORTANT: Review each section before running and comment out anything
# you don't want to apply. Some changes require a logout/restart to take effect.
# =============================================================================

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}


log_info "Starting macOS setup script..."

# =============================================================================
# 1. SYSTEM PREFERENCES - KEYBOARD & MOUSE
# =============================================================================
log_info "Configuring keyboard and mouse settings..."

# Set key repeat rate (fast)
defaults write NSGlobalDomain KeyRepeat -int 2

# Set initial key repeat delay (short)
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Enable full keyboard access for all controls (Tab to select any control)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

log_success "Keyboard settings configured"

# Enable tap to click for trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Enable three finger drag
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Set tracking speed (0 = slow, 3 = fast)
defaults write NSGlobalDomain com.apple.mouse.scaling -float 2.5
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5

log_success "Mouse/trackpad settings configured"

# =============================================================================
# 2. SYSTEM PREFERENCES - DOCK & MISSION CONTROL
# =============================================================================
log_info "Configuring Dock and Mission Control..."

# Set Dock size
defaults write com.apple.dock tilesize -int 50

# Enable Dock magnification
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 80

# Position Dock on the bottom
defaults write com.apple.dock orientation -string "bottom"

# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0.1
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Hot corners - bottom right corner for desktop
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

log_success "Dock settings configured"

# =============================================================================
# 3. FINDER PREFERENCES
# =============================================================================
log_info "Configuring Finder settings..."

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable warning when changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

log_success "Finder settings configured"

# =============================================================================
# 4. INSTALL HOMEBREW & PACKAGE MANAGER
# =============================================================================
log_info "Installing Homebrew and essential tools..."

if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    
    log_success "Homebrew installed"
else
    log_info "Homebrew already installed"
fi

# =============================================================================
# 5. INSTALL DEVELOPMENT TOOLS
# =============================================================================
log_info "Installing development tools..."

if command -v brew &> /dev/null; then
    # Development tools
    brew_packages=(
        git
        node
        python3
        curl
        wget
        jq
        tree
        htop
        ripgrep
        fd
        bat
        fzf
        neovim
        tmux
        gh
    )
    
    log_info "Installing: ${brew_packages[*]}"
    brew install "${brew_packages[@]}"
    
    log_success "Development tools installed"
    
    # GUI Applications
    cask_packages=(
        # visual-studio-code
    )
    
    log_info "Installing: ${cask_packages[*]}"
    brew install --cask "${cask_packages[@]}"
    
    log_success "GUI applications installed"
fi

# =============================================================================
# 6. TERMINAL & SHELL CONFIGURATION
# =============================================================================
log_info "Configuring shell environment..."

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Basic .zshrc configuration
cat > ~/.zshrc << 'EOF'
# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git node npm python brew macos fzf)

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8
export EDITOR='code'

# Initialize fzf if available
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
fi
EOF

log_success "Zsh configuration created"

# =============================================================================
# 7. GIT CONFIGURATION
# =============================================================================
log_info "Configuring Git..."

git config --global user.name "mheiber"
git config --global user.email "max.heiber@gmail.com"
git config --global init.defaultBranch main
git config --global pull.rebase false


# =============================================================================
# 8. MACOS SECURITY & PRIVACY SETTINGS
# =============================================================================
log_info "Configuring security and privacy settings..."

# Require password after sleep/screensaver (5 seconds)
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 5

# Enable firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Disable automatic login
sudo defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser 2>/dev/null || true

log_success "Security settings configured"

# =============================================================================
# 9. ADDITIONAL SYSTEM TWEAKS
# =============================================================================
log_info "Applying additional system tweaks..."

# Disable startup chime
sudo nvram SystemAudioVolume=" "

# Expand save and print dialogs by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Disable "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Show battery percentage in menu bar
defaults write com.apple.menuextra.battery ShowPercent -bool true

# Enable AirDrop over Ethernet and on unsupported Macs
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Disable auto-correct and auto-capitalization
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

log_success "Additional system tweaks applied"

# =============================================================================
# 10. RESTART AFFECTED SERVICES
# =============================================================================
log_info "Restarting affected services..."

# Restart affected applications/services
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

log_success "Services restarted"

# =============================================================================
# 11. FINAL STEPS & RECOMMENDATIONS
# =============================================================================
log_success "Setup script completed!"

echo ""
log_info "=== FINAL STEPS ==="
echo "1. Restart your computer to ensure all settings take effect"
echo "2. Sign into your Apple ID in System Preferences"
echo "3. Configure iCloud services as needed"
echo "4. Install any additional software from the Mac App Store"
echo "5. Set up SSH keys for GitHub: ssh-keygen -t ed25519 -C \"your_email@example.com\""
echo "6. Configure any remaining application preferences manually"
echo ""

log_warning "Some changes require a restart to take effect fully."

log_info "Remember to restart later to apply all changes."

echo ""
log_success "macOS setup complete! 🎉"
