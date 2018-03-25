"
" ~/.vim/vimsrc/interface.vim
"

" miscellaneous
	set ttimeoutlen=50
	set updatetime=250
" status bar
	set wildmenu
	set laststatus=2
	"set noshowmode
	"set showcmd " unset by lightline?
	set statusline=%F\ %m%r%y%=%-9(%l/%L,%)\ %-9(%c%V,%)\ %P
" buffers, windows
	set splitbelow splitright
	set hidden
" search
	set hlsearch
	set ignorecase smartcase
" text
	set foldmethod=indent
	set number
	set linebreak wrap list
	set listchars=tab:>-,trail:~,extends:>,precedes:<
	set nojoinspaces " insert `J` adds only 1 space for .?!
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
