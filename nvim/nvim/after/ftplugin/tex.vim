function CR()
    if searchpair('\\begin{itemize}', '', '\\end{itemize}', '')
        return "\r\\item "
    endif
    if searchpair('\\begin{enumerate}', '', '\\end{enumerate}', '')
        return "\r\\item "
    endif
    return "\r"
endfunction

inoremap <expr><buffer> <CR> CR()

" Ensures that working directory is set to the current file
autocmd BufEnter *.tex silent! :lcd%:p:h

nnoremap <buffer> ; :!pdflatex -shell-escape -output-directory %:p:h %<CR>
nnoremap <buffer> ' :!bibtex %:r<CR>

nnoremap <buffer> <leader>ra :lua LatexTableAlign()<CR>

vnoremap <buffer> <leader>rs <ESC>gv:s/^\([^ \|^)]\)/R> \1/g<CR>gv:s/\(^[ )]\)/+  \1<CR>
