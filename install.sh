#!/bin/bash

# Run this from the dotfiles dir
DOTFILES=`pwd`

# bash
mv ~/.bashrc ~/.bashrc.local 2> /dev/null
ln -s $DOTFILES/bashrc ~/.bashrc
#touch ~/.bashrc.local

# vim
mv ~/.vimrc ~/.vimrc.old 2> /dev/null
mv ~/.vim ~/.vim.old 2> /dev/null
ln -s $DOTFILES/vimrc ~/.vimrc
ln -s $DOTFILES/vim ~/.vim

# screen
mv ~/.screenrc ~/.screenrc.old 2> /dev/null
ln -s $DOTFILES/screenrc ~/.screenrc

# dircolors
mv ~/.dir_colors ~/.dir_colors.old 2> /dev/null
ln -s $DOTFILES/dircolors/dircolors.ansi-dark ~/.dir_colors

sudo apt-get install exuberant-ctags vim --default
git submodule update --init

