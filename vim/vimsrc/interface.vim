"
" ~/.vim/vimsrc/interface.vim
"

" miscellaneous
	set ttimeoutlen=50
	set updatetime=250
" status bar
	set wildmenu
	set laststatus=2
	set showcmd
	" disabled by lightline, but here for the record
	"set statusline=%F\ %m%r%y%=%-9(%l/%L,%)\ %-9(%c%V,%)\ %P
" buffers, windows
	set splitbelow splitright
	set hidden
" search
	set hlsearch
	set ignorecase smartcase
" text
	set foldmethod=indent
	set number relativenumber
	set linebreak wrap list
	set listchars=tab:>-,trail:~,extends:>,precedes:<
	set nojoinspaces
" tabs
	set smarttab tabstop=4 shiftwidth=4
" movement
	set cursorline
	set autoindent
	set nostartofline
	set scrolloff=5
" highlighting
	syntax enable
	set background=dark
	highlight SpellBad ctermbg=none cterm=bold,underline
	highlight SpellCap ctermbg=none cterm=bold,underline
