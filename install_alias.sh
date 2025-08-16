#!/usr/bin/env bash
set -euo pipefail

ZSHRC="$HOME/.zshrc"
ALIAS_CMD="alias v=nvim"

if grep -qxF "$ALIAS_CMD" "$ZSHRC"; then
  echo "✅ Already exists: $ALIAS_CMD"
else
  echo "$ALIAS_CMD" >>"$ZSHRC"
  echo "➕ Added: $ALIAS_CMD"
fi

echo
echo "⚠️ Please run 'source ~/.zshrc' or restart your terminal to apply the changes."