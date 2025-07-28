" Ensures that working directory is set to the current file
autocmd BufEnter *.md silent! :lcd%:p:h

" Quick compile to PDF
nnoremap <buffer> <F1> :!pandoc % -o %:r.pdf<CR>

" Open links
nnoremap <buffer> <CR> gf
nnoremap <buffer> <M-CR> gx

" Jump to link
nnoremap <buffer> <Tab> /](<CR>

" Insert current time
nnoremap <buffer> <leader>it :lua CurrentTime()<CR>

" Insert current date
nnoremap <buffer> <leader>id :lua CurrentDate()<CR>

let g:markdown_fenced_languages = ['bash', 'python', 'r']

" Spell
setlocal spell
