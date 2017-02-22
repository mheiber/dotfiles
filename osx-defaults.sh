
# fast mission control
defaults write com.apple.dock expose-animation-duration -float 0.12 && killall Dock

# show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool YES && killall Finder

# change screenshot location
mkdir -p ~/Screenshots
defaults write com.apple.screencapture type jpg && killall SystemUIServer

# always show library
chflags nohidden ~/Library/
