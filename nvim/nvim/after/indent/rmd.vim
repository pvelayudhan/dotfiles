setlocal indentexpr=""

au FileType quarto setl comments=b:*,b:-,b:+,n:>
au FileType quarto setl formatoptions+=r
