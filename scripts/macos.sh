#!/usr/bin/env bash

# macOS defaults — curated for modern macOS (Sonoma/Sequoia)

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable smart quotes as they're annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they're annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Show scrollbars only when scrolling
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Drag windows from anywhere with Ctrl+Cmd
defaults write NSGlobalDomain NSWindowShouldDragOnGesture -bool true

###############################################################################
# Keyboard                                                                    #
###############################################################################

# Enable key repeat (instead of the accent popup) in all apps
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

###############################################################################
# Screen                                                                      #
###############################################################################

# Save screenshots to ~/Screenshots
defaults write com.apple.screencapture location -string "$HOME/Screenshots"

# Save screenshots in PNG format
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show external/removable drives on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Remove items from Trash after 30 days
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network and USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show the ~/Library folder
chflags nohidden ~/Library

# Expand File Info panes: General, Open with, Sharing & Permissions
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true

###############################################################################
# Dock                                                                        #
###############################################################################

# Set icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

# Use scale effect for minimize
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application icon
defaults write com.apple.dock minimize-to-application -bool true

# Show indicator lights for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

###############################################################################
# Terminal                                                                    #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

###############################################################################
# Mail                                                                        #
###############################################################################

# Copy email addresses as "foo@example.com" instead of "Foo Bar <foo@example.com>"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

###############################################################################
# Restart affected applications                                               #
###############################################################################

for app in "Dock" "Finder" "SystemUIServer"; do
  killall "$app" &>/dev/null
done

echo "macOS defaults applied. Some changes may require a logout/restart."
