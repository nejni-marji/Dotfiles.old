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

" vim-commentary
augroup commentary
	autocmd!
	autocmd FileType vim :setlocal commentstring=\"%s
	autocmd FileType conf :setlocal commentstring=#%s
	autocmd FileType python :setlocal commentstring=#%s
	autocmd FileType sh :setlocal commentstring=#%s
augroup END

" quick-scope
"let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
