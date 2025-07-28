highlight ConcealedText ctermfg=gray guifg=gray
syntax match ConcealedText /\([^,]\{20}\)\zs[^,]*/ conceal cchar=*

set conceallevel=2
