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


