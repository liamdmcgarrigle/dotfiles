#!/bin/bash
# Screenshot notification helper script
# Usage: send-screenshot-notification.sh <filepath> <title> [description]

FILEPATH="$1"
TITLE="$2"
DESCRIPTION="${3:-}"

# Validate required parameters
if [[ -z "$FILEPATH" || -z "$TITLE" ]]; then
    echo "Usage: $0 <filepath> <title> [description]"
    echo "Example: $0 /path/to/screenshot.png 'Screenshot Saved' 'Region captured'"
    exit 1
fi

# Check if file exists
if [[ ! -f "$FILEPATH" ]]; then
    notify-send "Screenshot Error" "File not found: $FILEPATH" -u critical -a "Screenshot"
    exit 1
fi

# Get just the filename for display
FILENAME=$(basename "$FILEPATH")

# Build the message
if [[ -n "$DESCRIPTION" ]]; then
    MESSAGE="$DESCRIPTION"
fi
MESSAGE="\n🖱️ Click for options"

# Send the notification
notify-send "$TITLE" \
    "$MESSAGE" \
    -i "$FILEPATH" \
    -a "Screenshot" \
    -t 8000
