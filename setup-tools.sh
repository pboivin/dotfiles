#!/usr/bin/env bash

TOOLS_DIR="$HOME/Workspace/tools"

if [ -e "$TOOLS_DIR" ]; then
  echo "Error: $TOOLS_DIR already exists"
  exit 1
fi

mkdir -p "$HOME/Workspace/tools"
cd "$HOME/Workspace/tools"

# Install z
git clone https://github.com/rupa/z.git z

echo
echo
echo "DONE!"
echo
echo "Please add the following to your bash configuration:"
echo '
# z

. "$HOME/Workspace/tools/z/z.sh"
'
echo
