#!/bin/bash
width=`tput cols`
lesson=${1%.*}
if (( width > 150 ))
then
  vim -S $lesson.vim -O $lesson.txt $lesson.vim
else
  vim -S $lesson.vim -o $lesson.txt $lesson.vim
fi
