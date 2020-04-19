#!/bin/bash

# link dotfiles
ln -sf nvim ${HOME}/.config/
ln -sf .tmux.conf $HOME

# install dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
rm installer.sh
