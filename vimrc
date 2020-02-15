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
map <C-g> :Termdebug<CR>


" NERDTree
set runtimepath^=~/.vim/bundle/nerdtree/
helptags ~/.vim/bundle/nerdtree/doc/  " :help Nerdtree/NERDTree
map <C-t> :NERDTreeToggle<CR>


" Auto Pairs
set runtimepath^=~/.vim/bundle/auto-pairs/
helptags ~/.vim/bundle/auto-pairs/doc/  " :help autopairs


" Buftabline
set runtimepath^=~/.vim/bundle/vim-buftabline/
helptags ~/.vim/bundle/vim-buftabline/doc/  " :help buftabline
map <C-n> :bnext<CR>
map <C-p> :bprev<CR>


" airline
set runtimepath^=~/.vim/bundle/vim-airline/
helptags ~/.vim/bundle/vim-airline/doc/  " :help airline


" airline-themes
set runtimepath^=~/.vim/bundle/vim-airline-themes/
helptags ~/.vim/bundle/vim-airline-themes/doc/  " help airline-theme/s
let g:airline_theme='base16_gruvbox_dark_hard'

