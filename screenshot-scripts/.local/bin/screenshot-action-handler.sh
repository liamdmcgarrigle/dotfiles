#!/bin/bash

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"

LATEST_SCREENSHOT=$(ls -t "$SCREENSHOT_DIR"/*.png 2>/dev/null | head -1)

ACTION=$(echo -e "📁 Browse to file\n🎨 Edit in GIMP\n📋 Copy file\n📋➡️🗑️ Copy & delete file\n📝 Copy path\n🗑️ Delete file" | wofi --dmenu --insensitive --matching fuzzy --prompt "Screenshot action:")

case "$ACTION" in
    "📁 Browse to file")
        if [[ -n "$LATEST_SCREENSHOT" ]]; then
            kitty yazi "$LATEST_SCREENSHOT"
        else
            kitty yazi "$SCREENSHOT_DIR"
        fi
        ;;
    "🎨 Edit in GIMP")
        if [[ -n "$LATEST_SCREENSHOT" ]]; then
            gimp "$LATEST_SCREENSHOT"
        else
            notify-send "Error" "No screenshot found"
        fi
        ;;
    "📋 Copy file")
        if [[ -n "$LATEST_SCREENSHOT" ]]; then
            wl-copy --type image/png < "$LATEST_SCREENSHOT"
            notify-send "📋 Copied" "Image file copied to clipboard - ready to paste!" -t 2000
        else
            notify-send "Error" "No screenshot found"
        fi
        ;;
    "📋➡️🗑️ Copy & delete file")
        if [[ -n "$LATEST_SCREENSHOT" ]]; then
            wl-copy --type image/png < "$LATEST_SCREENSHOT"
            rm "$LATEST_SCREENSHOT"
            notify-send "📋 Copied" "Image copied to clipboard and deleted - ready to paste!" -t 2000
        else
            notify-send "Error" "No screenshot found"
        fi
        ;;
  
    "📝 Copy path")
        if [[ -n "$LATEST_SCREENSHOT" ]]; then
            PRETTY_PATH="${LATEST_SCREENSHOT/#$HOME/~}"
            echo -n "$PRETTY_PATH" | wl-copy
            notify-send "📝 Copied" "Path copied: $PRETTY_PATH" -t 2000
        else
            notify-send "Error" "No screenshot found"
        fi
        ;;
    "🗑️ Delete file")
        if [[ -n "$LATEST_SCREENSHOT" ]]; then
            FILENAME=$(basename "$LATEST_SCREENSHOT")
            rm "$LATEST_SCREENSHOT"
            notify-send "🗑️ Deleted" "Screenshot removed: $FILENAME" -t 2000
        else
            notify-send "Error" "No screenshot found"
        fi
        ;;
esac
