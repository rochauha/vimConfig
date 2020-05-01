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
nnoremap <S-n> :bnext <CR>
nnoremap <S-p> :bprev <CR>
inoremap <TAB> <C-n>
tnoremap <ESC> <C-\><C-n>


" Additional Silver Searcher config to ease life
if executable('ag')
  " Requires ag to be installed
  " See https://github.com/ggreer/the_silver_searcher for details

  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Bind <S-f> to grep for word under the cursor
  nnoremap <S-f> :silent! grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

  " Bind <C-f> to grep shortcut
  command -nargs=+ -complete=file -bar Find silent! grep! <args>|cwindow|redraw!
  nnoremap <C-f> :Find<SPACE>
endif



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


" CtrlP
set runtimepath^=~/.config/nvim/bundle/ctrlp.vim/
helptags ~/.config/nvim/bundle/ctrlp.vim/doc/  " :help ctrlp
set wildignorecase
set wildignore+=*/tmp/*,*/.git/*,*/__pycache__/*,*/log/*,*/.DS_Store
set wildignore+=*.o,*.so
set wildignore+=*.tar,*.zip,*.tgz,*.rar,*.7z
set wildignore+=*.swp
set wildignore+=*.deb,*.rpm
set wildignore+=*.pdf,*.epub,*.djvu
set wildignore+=*.doc.*.docx,*.xls,*.xlsx,*.ppt,*.pptx
set wildignore+=*.jpg,*.png,*.gif
set wildignore+=*.flac,*.m4a,*.mp3
set wildignore+=*.mkv,*.mp4
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_max_depth = 20
let g:ctrlp_max_files = 0  " 0 implies no limit on #files to scan
let g:ctrlp_working_path_mode = 0 " 0 implies disable this feature
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:15,results:15'


" Auto Pairs
set runtimepath^=~/.config/nvim/bundle/auto-pairs/
helptags ~/.config/nvim/bundle/auto-pairs/doc/  " :help autopairs


" any-jump
set runtimepath^=~/.config/nvim/bundle/any-jump.vim/
helptags ~/.config/nvim/bundle/any-jump.vim/doc/  " :help any-jump
let g:any_jump_grouping_enabled = 1  " group search results by file
if executable('ag')
  let g:any_jump_search_prefered_engine = 'ag' " requires ag to be installed
endif


" airline
set runtimepath^=~/.config/nvim/bundle/vim-airline/
helptags ~/.config/nvim/bundle/vim-airline/doc/  " :help airline
let g:airline_powerline_fonts = 1  " requires powerline fonts to be installed
let g:airline#extensions#tabline#enabled = 1 " enable tabline
let g:airline#extensions#tabline#formatter = 'unique_tail'
