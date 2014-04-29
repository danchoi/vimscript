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

func! ThesaurusCompletion()
  let word = expand("<cword>")
  let synonyms = split(system("./thes.sh ".word , '\n'))
  if a:findstart
    return 0
  else
    if (a:base == '')
      return synonyms
    else
      let res = []
      for x in synonyms
        if x =~ a:base 
          call add(res, x)
        endif
      endfor
      return res
    endif
  endif
endfunc
" setlocal completefunc=ThesaurusCompletion

func! DropDownOne()
  " leftabove split DropDownOne
  belowright split DropDownOne
  let g:SelectionList = split(system("find .", '\n'))
  " help 'completefunc'; help complete-functions
  setlocal completefunc=DropDownCompletion
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal modifiable
  resize 1
  inoremap <buffer> <cr> <Esc>:call ReadDropDownSelection()<CR>
  noremap <buffer> q <Esc>:close<CR>
  inoremap <buffer> <Esc> <Esc>:close<CR>
  call setline(1, "Your selection?  ")
  normal $
  inoremap <buffer> <Tab> <C-x><C-u>
  call feedkeys("a\<c-x>\<c-u>\<c-p>", 't')
endfunc

func! ReadDropDownSelection()
  let g:drop_down_selection = getline('.')
  let g:selection = join(split(getline('.'), '? *')[1:])
  close
  put =g:selection
endfunc

func! DropDownCompletion(findstart, base)
  if a:findstart
    return len("Your selection?  ")
  else
    if (a:base == '')
      return g:SelectionList
    else
      let res = []
      for m in g:SelectionList
        if m =~ a:base 
          call add(res, m)
        endif
      endfor
      return res
    endif
  endif
endfunc


