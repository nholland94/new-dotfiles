#!/bin/bash

DIR=$(pwd)
FILES=".vimrc .tmux.conf"

warn()
{
  echo -e "\x1B[31m$1\x1B[0m"
}

link_to()
{
  TARGET="$2/$1"
  if [ -a "$TARGET" ]; then
    warn "$TARGET exists! Refusing to symlink."
  else
    ln -s $TARGET "$DIR/$1"
  fi
}

for FILE in $FILES; do
  link_to $FILE $HOME
done

echo -e '\x1B[32mSuccess!\x1B[0m'
