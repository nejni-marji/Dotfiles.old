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
" vim-ctrlspace
" Commenting out this while removing vim-ctrlspace from bundle
" because I rarely use the plugin and it was 120 megs.
" Dating this comment 2016-11-27
" let g:CtrlSpaceUseUnicode = 0
" vim-gitgutter
let g:gitgutter_realtime = 1
