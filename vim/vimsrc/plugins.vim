"
" ~/.vim/vimsrc/plugins.vim
"

execute pathogen#infect('~/.vim/bundle/{}')

" lightline.vim
let g:lightline = {
\ 'colorscheme': 'solarized',
\ 'component': {
\ },
\ 'separator': { 'left': '', 'right': '' },
\ 'subseparator': { 'left': '', 'right': '' }
\ }

" vim-gitgutter
let g:gitgutter_realtime = 1
