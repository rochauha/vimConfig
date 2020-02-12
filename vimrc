syntax on
set background=dark
colorscheme gruvbox 

set number
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set showmatch

set cursorline


" Termdebug
packadd termdebug


" NERDTree
set runtimepath^=~/.vim/bundle/nerdtree/
map <C-n> :NERDTreeToggle<CR>


" Auto Pairs
set runtimepath^=~/.vim/bundle/auto-pairs/


" airline
set runtimepath^=~/.vim/bundle/vim-airline/


" airline-themes
set runtimepath^=~/.vim/bundle/vim-airline-themes/
let g:airline_theme='base16_gruvbox_dark_hard'

