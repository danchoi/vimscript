" window control is the last step
" key bindings
" variable scope

func! HelloWorld()
  echo "hello world"
endfunc

func! PutHelloWorld()
  let msg = "hello world"
  put =msg
endfunc

func! PutSystemRes()
  let msg = system("ls -l")
  " :help :pu
  put! =msg
endfunc

func! PutSystemResReplaceBuffer()
  1,$delete
  let msg = system("ls -l")
  put! =msg
endfunc

" Happy
func! ThesaurusCompletion(findstart, base)
  if a:findstart
    return len("Pick a synonym:  ")
  else
    if (a:base == '')
      return g:synonyms
    else
      let res = []
      for x in g:synonyms
        if x =~ a:base 
          call add(res, x)
        endif
      endfor
      return res
    endif
  endif
endfunc
func! Thesaurus()
  let word = expand("<cword>")
  let matches = system("./thes.sh ".word )
  let g:synonyms = split(matches, '\n')
  leftabove split Thesaurus
  setlocal completefunc=ThesaurusCompletion
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal modifiable
  resize 1
  inoremap <buffer> <cr> <Esc>:call SelectSynonym()<CR>
  noremap <buffer> q <Esc>:close<CR>
  inoremap <buffer> <Esc> <Esc>:close<CR>
  call setline(1, "Pick a synonym:  ")
  normal $
  inoremap <buffer> <Tab> <C-x><C-u>
  call feedkeys("a\<c-x>\<c-u>\<c-p>", 't')
endfunc

nnoremap T :call Thesaurus()<CR>

func! SelectSynonym()
  let g:selection = join(split(getline('.'), ': *')[1:])
  close
  if g:selection =~ '\w'
    exec "normal caw".g:selection.' '
  endif
endfunc

