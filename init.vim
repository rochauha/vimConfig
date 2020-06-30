"""""""""" EDITOR SETTINGS """"""""""

autocmd VimEnter * clearjumps  " clear jumplist at startup
set backspace=indent,eol,start " Fixes common backspace problems

set encoding=utf-8
set nocompatible  " vim mode only; go beyond vi
syntax on         " enable syntax highlighting
set number        " show line numbers
filetype plugin indent on
set title
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set copyindent    " copy indentation structure of existing code
set autoread      " enable reloading file on external changes
set hidden        " enable changing buffer without saving
set cursorline    " highlight current line
set nohlsearch    " don't highlight all search results for a pattern
set ignorecase    " ignore case when searching
set incsearch     " enable incremental search
set showmode
set showcmd
set cmdheight=1
set mouse=nv      " mouse support in normal and visual mode


"""""""""" COLOR CONFIG """"""""""

" gruvbox scheme
set runtimepath^=~/.config/nvim/bundle/gruvbox
set background=dark
colorscheme gruvbox

if &background ==# 'dark'
  set notermguicolors
  let g:gruvbox_contrast_dark='medium'
  highlight QuickFixLine ctermfg=250
elseif &background ==# 'light'
  set termguicolors
  let g:gruvbox_contrast_light='soft'
  highlight QuickFixLine guifg=#87005f
endif


" Highlight trailing whitespaces in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()



"""""""""" KEY BINDING CONFIG """"""""""

" To enable C-s and C-q in terminal
silent !stty -ixon
autocmd VimLeave * : silent !stty -ixon

nnoremap <C-s> :update <CR>
nnoremap <C-q> :qa! <CR>
nnoremap <C-x> :bd! <CR>
nnoremap <TAB> :bnext <CR>
nnoremap <S-TAB> :bprev <CR>
tnoremap <ESC> <C-\><C-n>


"""""""""" PLUGIN CONFIG """"""""""

" Termdebug
packadd termdebug
nnoremap <C-g> :Termdebug <CR>


" NERDTree
set runtimepath^=~/.config/nvim/bundle/nerdtree/
helptags ~/.config/nvim/bundle/nerdtree/doc/  " :help Nerdtree/NERDTree
nnoremap <C-t> :NERDTreeToggle <CR>


" NERDCommenter
set runtimepath^=~/.config/nvim/bundle/nerdcommenter/
helptags ~/.config/nvim/bundle/nerdcommenter/doc/  " :help NerdCommenter/NERDCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1


" fzf
" (Requires fzf and rg to be installed)
set runtimepath^=~/.config/nvim/bundle/fzf/ " Whole fzf repo, for the base fzf plugin
set runtimepath^=~/.config/nvim/bundle/fzf.vim/ " For the 'actual' fzf plugin
helptags ~/.config/nvim/bundle/fzf.vim/doc/  " :help fzf
let g:fzf_height='100%'
nnoremap <C-p> :Files <CR>
nnoremap <Leader>t :BTags <CR>
nnoremap <Leader>T :Tags <CR>
nnoremap <Leader>l :BLines <CR>
nnoremap <Leader>L :Lines <CR>
nnoremap <C-f> :Rg<SPACE>


" Auto Pairs
set runtimepath^=~/.config/nvim/bundle/auto-pairs/
helptags ~/.config/nvim/bundle/auto-pairs/doc/  " :help autopairs


" airline
set runtimepath^=~/.config/nvim/bundle/vim-airline/
helptags ~/.config/nvim/bundle/vim-airline/doc/  " :help airline
let g:airline_powerline_fonts = 1  " requires powerline fonts to be installed
let g:airline#extensions#tabline#enabled = 1 " enable tabline
let g:airline#extensions#tabline#formatter = 'unique_tail'
