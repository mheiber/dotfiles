#!/bin/bash

# Simple iTerm2 settings backup and restore script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$SCRIPT_DIR/iterm-backup"

# If backup exists, restore it. Otherwise, create backup.
if [ -d "$BACKUP_DIR" ]; then
    echo "Restoring iTerm2 settings..."
    
    # Quit iTerm2 if running
    pkill -x iTerm2 2>/dev/null || true
    sleep 1
    
    # Restore preferences
    cp "$BACKUP_DIR/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/" 2>/dev/null || true
    cp "$BACKUP_DIR/com.googlecode.iterm2.private.plist" "$HOME/Library/Preferences/" 2>/dev/null || true
    
    # Restore dynamic profiles if they exist
    if [ -d "$BACKUP_DIR/DynamicProfiles" ]; then
        mkdir -p "$HOME/Library/Application Support/iTerm2/DynamicProfiles"
        cp -r "$BACKUP_DIR/DynamicProfiles/"* "$HOME/Library/Application Support/iTerm2/DynamicProfiles/"
    fi
    
    echo "iTerm2 settings restored. Restart iTerm2 to apply changes."
else
    echo "Creating iTerm2 settings backup..."
    
    mkdir -p "$BACKUP_DIR"
    
    # Backup main preferences
    cp "$HOME/Library/Preferences/com.googlecode.iterm2.plist" "$BACKUP_DIR/" 2>/dev/null || echo "Warning: Main plist not found"
    cp "$HOME/Library/Preferences/com.googlecode.iterm2.private.plist" "$BACKUP_DIR/" 2>/dev/null || echo "Warning: Private plist not found"
    
    # Backup dynamic profiles if they exist
    if [ -d "$HOME/Library/Application Support/iTerm2/DynamicProfiles" ]; then
        cp -r "$HOME/Library/Application Support/iTerm2/DynamicProfiles" "$BACKUP_DIR/"
    fi
    
    echo "iTerm2 settings backed up to $BACKUP_DIR"
    echo "Copy this dotfiles directory to your new Mac and run this script again."
fi