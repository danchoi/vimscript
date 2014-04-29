
func! FindHref()
  let pat = 'https\?:[^ >)\]]\+'
  let res = search(pat, 'cw')
  if res != 0
    return expand("<cWORD>") 
  end
endfunc

func! OpenHref()
  let command = "open  '" . shellescape(FindHref()) . "' "
  call system(command)
endfunc

nnoremap <leader>P :call OpenHref()<CR>


