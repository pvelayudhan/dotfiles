nnoremap <buffer> <F1> :call TypstCompile()<CR>

function! TypstCompile()
  let cwd = getcwd()

  if cwd =~# 'pv-thesis' || cwd =~# 'book'
    !typst compile main.typ
  elseif expand('%:t') =~# 'html\.typ$'
    !vel_typst_html_compile %
  else
    !typst compile %
  endif
endfunction

setlocal foldmethod=marker
setlocal foldmarker=\ //\ {{{,\ //\ }}}
