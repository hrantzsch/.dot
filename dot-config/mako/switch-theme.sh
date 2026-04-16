#!/bin/sh

SCRIPT_DIR="$(realpath "$(dirname "$0")")"
CONFIG="$SCRIPT_DIR/config"

if [ ! -f "$CONFIG" ]; then
  echo "config file not found in $SCRIPT_DIR"
  exit 1
fi

DAWN_BACKGROUND_COLOR=#f2e9e1
DAWN_TEXT_COLOR=#575279
DAWN_BORDER_COLOR=#286983

MOON_BACKGROUND_COLOR=#393552
MOON_TEXT_COLOR=#e0def4
MOON_BORDER_COLOR=#3e8fb0

if [ "$1" = "dawn" ]; then
  BACKGROUND_COLOR="$DAWN_BACKGROUND_COLOR"
  TEXT_COLOR="$DAWN_TEXT_COLOR"
  BORDER_COLOR="$DAWN_BORDER_COLOR"
else
  BACKGROUND_COLOR="$MOON_BACKGROUND_COLOR"
  TEXT_COLOR="$MOON_TEXT_COLOR"
  BORDER_COLOR="$MOON_BORDER_COLOR"
fi

sed -i "s/^background-color=.*/background-color=$BACKGROUND_COLOR/g" "$CONFIG"
sed -i "s/^text-color=.*/text-color=$TEXT_COLOR/g" "$CONFIG"
sed -i "s/^border-color=.*/border-color=$BORDER_COLOR/g" "$CONFIG"

makoctl reload
notify-send "Mako theme switched"
