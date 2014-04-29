#!/bin/bash
lesson=${1:-1_hello}
vim -S $1.vim -O $1.txt $1.vim
