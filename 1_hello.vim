func! HelloWorld()
  echo "hello world"
endfunc

nnoremap <leader>h <ESC>:call HelloWorld()<CR>

command! Hello :call HelloWorld()

func! PutHelloWorld()
  let msg = "hello world"
  put =msg
endfunc

nnoremap <leader>H :call PutHelloWorld()<CR>


