nnoremap ; vip}:SlimeSend<CR>}j
nnoremap <leader>fo :!black %<CR>

" Only add 4 spaces following python indent
let g:pyindent_open_paren=4

nnoremap <buffer> <leader>lf :!black --line-length 79 %<CR>:!flake8<CR>
