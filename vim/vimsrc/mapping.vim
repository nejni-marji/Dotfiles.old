"
" ~/.vim/vimsrc/mapping.vim
"

" miscellaneous maps
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
nnoremap <leader>tcc :set cursorcolumn! cursorcolumn?<CR>
nnoremap <leader>tcl :set cursorline! cursorline?<CR>
nnoremap <leader>th :set hlsearch! hlsearch?<CR>
nnoremap <leader>tl :set list! list?<CR>
nnoremap <leader>tn :set number! number?<CR>
nnoremap <leader>tN :set relativenumber! relativenumber?<CR>
nnoremap <leader>tp :set paste! paste?<CR>
nnoremap <leader>ts :set spell! spell?<CR>
nnoremap <leader>tw :set wrap! wrap?<CR>
" toggle complex settings
nnoremap <leader>TS :syntax off<CR>:syntax on<CR>
nnoremap <leader>Td :windo set diff<CR>
nnoremap <leader>TD :windo set nodiff<CR>
nnoremap <leader>Te :source ~/.vim/vimsrc/eo-x/start.vim<CR>
nnoremap <leader>TE :source ~/.vim/vimsrc/eo-x/stop.vim<CR>
