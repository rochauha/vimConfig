"""""""""" EDITOR SETTINGS """"""""""

autocmd VimEnter * clearjumps  " Clear jumplist at startup
set backspace=indent,eol,start " Fixes common backspace problems

set encoding=utf-8
set background=dark
syntax enable     " Enable syntax highlighting
set number        " Show line numbers
filetype plugin indent on
set title
set tabstop=2     " Set width of <TAB> character to 2 spaces
set expandtab     " Expand tabs to spaces
set shiftwidth=2  " Set 1 level of indent = 2 spaces
set shiftround    " Round indent to multiple of 'shiftwidth' when indenting with > and < manually
set autoindent    " Apply indentation of current line to next line
set copyindent    " Copy indentation structure of existing code
set autoread      " Enable reloading file on external changes
set hidden        " Enable changing buffer without saving
set cursorline    " Highlight current line
set nohlsearch    " Don't highlight all search results for a pattern
set ignorecase    " Ignore case when searching
set incsearch     " Enable incremental search
set mouse=nv      " Mouse support in normal and visual mode

set wrap          " Enable soft wrapping text at end of screen
set linebreak     " Wrap at a whitespace only

call plug#begin()
Plug 'sainnhe/gruvbox-material'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'rhysd/vim-llvm'
call plug#end()


"""""""""" COLOR CONFIG """"""""""

" Use 24bit color
if (has("termguicolors"))
 set termguicolors
endif

colorscheme gruvbox-material

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

" Some common shortcuts
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
nnoremap <C-t> :NERDTreeToggle <CR>

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


" NERDCommenter
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


" airline
" let g:airline_powerline_fonts = 1  " requires powerline fonts to be installed
let g:airline#extensions#tabline#enabled = 1 " enable tabline
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme = 'gruvbox_material'


" fzf
" (Requires fzf and rg to be installed)
let g:fzf_height='100%'
nnoremap <C-p> :Files <CR>
nnoremap <Leader>t :BTags <CR>
nnoremap <Leader>T :Tags <CR>
nnoremap <Leader>l :BLines <CR>
nnoremap <Leader>L :Lines <CR>
nnoremap <C-f> :Rg<SPACE>
