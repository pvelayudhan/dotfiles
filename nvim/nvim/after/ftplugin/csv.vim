setlocal nowrap

" Shift + tab moves to the previous comma
inoremap <buffer> <S-Tab> <ESC>?,<CR>li
nnoremap <buffer> <S-Tab> ?,<CR>?,<CR>l

" Tab moves to the next comma
inoremap <buffer> <Tab> <ESC>/,<CR>li
nnoremap <buffer> <Tab> /,<CR>l

" Insert current time
nnoremap <buffer> <leader>it :lua CurrentTime()<CR>

" Insert current date
nnoremap <buffer> <leader>id :lua CurrentDate()<CR>

" Align the CSV
nnoremap <buffer> <leader>ra :silent! RainbowAlign<CR>

" Shrink the CSV
nnoremap <buffer> <leader>rs :silent! RainbowShrink<CR>

" Replicate a previous entry to start now
nnoremap <buffer> <leader>rc yyGp$?,<CR>?,<CR>lDa,,<ESC>hh:lua CurrentTime()<CR>0d/,<CR>i<Space><Esc>:lua CurrentDate()<CR>:RainbowAlign<CR>$ba<Esc>

" Change entry
nnoremap <buffer> de dE
nnoremap <buffer> ce cE<ESC>:silent! RainbowAlign<CR>a

" Change entry (column object style)
nnoremap <buffer> cic ?,<CR>lc/,<CR>
