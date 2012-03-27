if exists("b:did_ftplugin")
  finish
endif

function! s:playground()
  if !executable('curl')
    echoerr "install curl command"    
    return
  endif
  echon 'Compiling and running...'
  let res = http#post('http://play.golang.org/compile', {"body": join(getline(1, line('$')), "\n")})
  let obj = json#decode(res.content)
  if has_key(obj, 'compile_errors') && len(obj.compile_errors)
    echohl WarningMsg | echo obj.compile_errors | echohl None
  elseif has_key(obj, 'output')
    echo obj.output
  endif
endfunction

command! -buffer Playground :call s:playground()
nnoremap <buffer> <localleader>e :Playground<cr>
