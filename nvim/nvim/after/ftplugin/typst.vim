nnoremap <buffer> <F1> :call TypstCompile()<CR>

function! TypstCompile()
  if expand('%:t') =~# 'html\.typ$'
    !vel_typst_html_compile %
  else
    !typst compile %
  endif
endfunction

setlocal foldmethod=marker
setlocal foldmarker=\ //\ {{{,\ //\ }}}
