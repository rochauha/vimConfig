-- ---------- EDITOR SETTINGS ----------

vim.cmd("autocmd VimEnter * clearjumps") -- Clear jumplist at startup
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")     -- Enable syntax highlighting

vim.opt.backspace  = "indent,eol,start" -- Fixes common backspace problems
vim.opt.encoding   = "utf-8"
vim.opt.title      = true   -- Set title of window to the value of the titlestring, leave titlestring default
vim.opt.number     = true   -- Show line numbers

-- Tab config
vim.opt.tabstop    = 2      -- Set width of <TAB> character to 2 spaces
vim.opt.expandtab  = true   -- Expand tabs to spaces
vim.opt.shiftwidth = 2      -- Set level of indent = 2 spaces
vim.opt.shiftround = true   -- Round indent to multiple of 'shiftwidth' when indenting with > and < manually
vim.opt.autoindent = true   -- Apply indentation of current line to next line
vim.opt.copyindent = true   -- Copy indentation structure of existing code

-- Search config
vim.opt.hlsearch   = false  -- Don't highlight all search results for a pattern
vim.opt.ignorecase = true   -- Ignore case when searching
vim.opt.incsearch  = true   -- Enable incremental search

vim.opt.autoread   = true   -- Enable reloading file on external changes
vim.opt.hidden     = true   -- Enable changing buffer without saving
vim.opt.cursorline = true   -- Highlight current line
vim.opt.mouse      = "nv"   -- Mouse support in normal and visual mode

vim.opt.wrap       = false   -- Disable soft wrapping text at end of screen
-- vim.opt.linebreak  = true   -- Wrap at a whitespace only


-- Install plugins
vim.api.nvim_exec(
  [[
    call plug#begin()
      Plug 'sainnhe/gruvbox-material'
      Plug 'preservim/nerdtree'
      Plug 'preservim/nerdcommenter'
      Plug 'vim-airline/vim-airline'
      Plug 'jiangmiao/auto-pairs'
      Plug 'junegunn/fzf'
      Plug 'junegunn/fzf.vim'
      Plug 'rhysd/vim-llvm'
      Plug 'neovim/nvim-lspconfig'
    call plug#end()
  ]], true
)

-- ---------- COLOR CONFIG ----------

-- Use 24bit color
-- the vim function returns 0 or 1, therefore compare to the number 0 or 1
if (vim.fn.has "termguicolors" == 1) then
  vim.opt.termguicolors = true
end

vim.cmd("colorscheme gruvbox-material")

-- Highlight trailing whitespaces in red
vim.cmd("highlight ExtraWhitespace ctermbg=red guibg=red")
vim.cmd("match ExtraWhitespace /\\s\\+$/")
vim.cmd("autocmd BufWinEnter * match ExtraWhitespace /\\s\\+$/")
vim.cmd("autocmd InsertEnter * match ExtraWhitespace /\\s\\+\\%#\\@<!$/")
vim.cmd("autocmd InsertLeave * match ExtraWhitespace /\\s\\+$/")
vim.cmd("autocmd BufWinLeave * call clearmatches()")


-- ---------- KEY BINDING CONFIG ----------

-- To enable C-s and C-q in terminal
vim.cmd("silent !stty -ixon")
vim.cmd("autocmd VimLeave * : silent !stty -ixon")

-- Common shortcuts
vim.keymap.set("n", "<C-s>", "<cmd>:update <CR>")
vim.keymap.set("n", "<C-q>", "<cmd>:qa! <CR>")
vim.keymap.set("n", "<C-x>", "<cmd>:bd! <CR>")
vim.keymap.set("n", "<TAB>", "<cmd>:bnext <CR>")
vim.keymap.set("n", "<S-TAB>", "<cmd>:bprev <CR>")
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")


-- ---------- PLUGIN CONFIG ----------

-- Termdebug
vim.cmd("packadd termdebug")
vim.keymap.set("n", "<C-g>", ":Termdebug <CR>")


-- NERDTree
vim.keymap.set("n", "<C-t>", ":NERDTreeToggle <CR>")

-- " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
-- autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


-- NERDCommenter
-- Add spaces after comment delimiters by default
vim.g.NERDSpaceDelims = 1

-- Use compact syntax for prettified multi-line comments
vim.g.NERDCompactSexyComs = true

-- Align line-wise comment delimiters flush left instead of following code indentation
vim.g.NERDDefaultAlign = "left"

-- Allow commenting and inverting empty lines (useful when commenting a region)
vim.g.NERDCommentEmptyLines = true

-- Enable trimming of trailing whitespace when uncommenting
vim.g.NERDTrimTrailingWhitespace = true

-- Enable NERDCommenterToggle to check all selected lines is commented or not
vim.g.NERDToggleCheckAllLines = true


-- airline
-- let g:airline_powerline_fonts = 1  " requires powerline fonts to be installed
vim.cmd("let g:airline#extensions#tabline#enabled = 1") -- enable tabline
vim.cmd("let g:airline#extensions#tabline#formatter = 'unique_tail'")
vim.g.airline_theme = 'gruvbox_material'


-- fzf
-- (Requires fzf and rg to be installed)
vim.g.fzf_height = "100%"
vim.keymap.set("n", "<C-p>", ":Files <CR>")
vim.keymap.set("n", "<Leader>t", ":BTags <CR>")
vim.keymap.set("n", "<Leader>T", ":Tags <CR>")
vim.keymap.set("n", "<Leader>l", ":BLines <CR>")
vim.keymap.set("n", "<Leader>L", ":Lines <CR>")
vim.keymap.set("n", "<C-f>", ":Rg<SPACE>")


-- LSP stuff
vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
vim.keymap.set('n', '<S-h>', function() vim.lsp.buf.hover() end, opts)
vim.keymap.set('n', '<S-r>', function() vim.lsp.buf.references() end, opts)

local lspconfig = require('lspconfig')
lspconfig.clangd.setup{} -- clangd for C/C++; requires clangd installed
