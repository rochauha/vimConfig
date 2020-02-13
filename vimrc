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
map <C-t> :NERDTreeToggle<CR>


" Auto Pairs
set runtimepath^=~/.vim/bundle/auto-pairs/


" Buftabline
set runtimepath^=~/.vim/bundle/vim-buftabline/
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>


" airline
set runtimepath^=~/.vim/bundle/vim-airline/


" airline-themes
set runtimepath^=~/.vim/bundle/vim-airline-themes/
let g:airline_theme='base16_gruvbox_dark_hard'

