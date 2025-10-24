#!/usr/bin/env bash
set -euo pipefail

LOGO_PATH="./logo.txt"

Ensure gum exists
if ! command -v gum &>/dev/null; then
    sudo pacman -Sy --noconfirm gum
fi

# Detect terminal size
if [ -e /dev/tty ]; then   # /dev/tty represents the current terminal
  TERM_SIZE=$(stty size 2>/dev/null </dev/tty) # Runs stty size to get the terminal size

  if [ -n "$TERM_SIZE" ]; then	# Checks if TERM_SIZE is not empty
	# Splits TERM_SIZE by space and assigns:
		# TERM_HEIGHT = number of rows
		# TERM_WIDTH = number of columns
		# export makes these variables available to subshells.
    export TERM_HEIGHT=$(echo "$TERM_SIZE" | cut -d' ' -f1)
    export TERM_WIDTH=$(echo "$TERM_SIZE" | cut -d' ' -f2)
  else
    # Fallback to reasonable defaults if stty fails
    export TERM_WIDTH=80
    export TERM_HEIGHT=24
  fi
else
  # No terminal available (e.g., non-interactive environment)
  export TERM_WIDTH=80
  export TERM_HEIGHT=24
fi

export LOGO_WIDTH=$(awk '{ if (length > max) max = length } END { print max+0 }' "$LOGO_PATH" 2>/dev/null || echo 0)
export LOGO_HEIGHT=$(wc -l <"$LOGO_PATH" 2>/dev/null || echo 0)

# Vertical padding to center
PADDING_TOP=$(( (TERM_HEIGHT - LOGO_HEIGHT) / 6 ))

# Print top padding
for ((i=0;i<PADDING_TOP;i++)); do
    echo ""
done

# Print logo centered horizontally
while IFS= read -r line; do
    LINE_WIDTH=${#line}
    PAD_LEFT=$(( (TERM_WIDTH - LINE_WIDTH) / 2 ))
    # Blue color: \033[34m ... \033[0m
	printf "%*s\033[34m%s\033[0m\n" $PAD_LEFT "" "$line"
done < "$LOGO_PATH"

# this is to be used at the end
# echo
# tte -i $LOGO_PATH --canvas-width 0 --anchor-text c --frame-rate 920 laseretch
# echo

