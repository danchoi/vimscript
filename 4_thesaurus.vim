

func! Thesaurus()
  let word = expand("<cword>")
  let matches = system("./thes.sh ".word )
  silent! vertical leftabove split Thesaurus
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal modifiable
  put! =matches
  setlocal nomodifiable
  vertical resize 20
  normal 1G
  nnoremap <buffer> <cr> <Esc>:call SelectSynonym()<CR>
  noremap <buffer> q <Esc>:close<CR>
  inoremap <buffer> <Esc> <Esc>:close<CR>
endfunc

func! SelectSynonym()
  let g:selection = getline(line('.'))
  close
  if g:selection =~ '\w'
    exec "normal ciw".g:selection
  endif
endfunc

nnoremap T :call Thesaurus()<CR>

