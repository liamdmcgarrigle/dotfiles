#!/bin/bash

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"
FILENAME="screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"
FILEPATH="$SCREENSHOT_DIR/$FILENAME"

grim "$FILEPATH"

$HOME/.local/bin/send-screenshot-notification.sh "$FILEPATH" "📸 Full Screen Captured"

