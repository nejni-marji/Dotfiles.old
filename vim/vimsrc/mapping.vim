"
" ~/.vim/vimsrc/mapping.vim
"

" miscellaneous maps
"cnoremap ww w " 2018-03-06, because it was bugging me when it happened outside of command mode? it shouldn't do that anw
"cnoremap W w " 2018-02-09 because I couldn't use capital W in searches
cnoremap Q q
nnoremap <leader>V :source ~/.vimrc<CR>
nnoremap <leader>W :write<CR>
nnoremap <leader>ln 80\|bhr
nnoremap <leader>lp 80\|bi"+ "<ESC>
" fix j/k with line wrap
nnoremap j gj
nnoremap k gk
nnoremap gk k
nnoremap gj j
" switch between buffers
nnoremap <leader>b :ls<CR>:buffer 
" toggle simple settings
nnoremap <leader>ta :set autoindent! autoindent?<CR>
nnoremap <leader>tc :set cursorcolumn! cursorcolumn?<CR>
nnoremap <leader>th :set hlsearch! hlsearch?<CR>
nnoremap <leader>tl :set list! list?<CR>
nnoremap <leader>ts :set spell! spell?<CR>
nnoremap <leader>tw :set wrap! wrap?<CR>
nnoremap <leader>tp :set paste! paste?<CR>
" toggle complex settings
nnoremap <leader>TS :syntax off<CR>:syntax on<CR>
nnoremap <leader>Td :windo set diff<CR>
nnoremap <leader>TD :windo set nodiff<CR>
nnoremap <leader>Te :source ~/.vim/vimsrc/eo-x/start.vim<CR>
nnoremap <leader>TE :source ~/.vim/vimsrc/eo-x/stop.vim<CR>
nnoremap <leader>Tn :set number! number?<CR>
nnoremap <leader>TN :set relativenumber! relativenumber?<CR>
