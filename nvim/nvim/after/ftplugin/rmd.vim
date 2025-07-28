function! FormatexprExample()
    let l1 = v:lnum
    let l2 = (v:lnum + v:count) - 1
    execute l1 .. ',' .. l2 .. 's/[(),]\n\@!/&\r/g'
    '[,.normal! ==
    return 0
endfunction
setlocal formatexpr=FormatexprExample()

nnoremap <buffer> <F1> :!Rscript -e "rmarkdown::render('%')"<CR>
