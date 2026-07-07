-- ---------- EDITOR SETTINGS ----------

vim.api.nvim_create_autocmd("VimEnter", {
  command = "clearjumps",
}) -- Clear jumplist at startup

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
vim.opt.cursorline = true   -- Highlight current line
vim.opt.mouse      = "nv"   -- Mouse support in normal and visual mode

vim.opt.wrap       = false   -- Disable soft wrapping text at end of screen
-- vim.opt.linebreak  = true   -- Wrap at a whitespace only


-- Install plugins
vim.pack.add({
  { src = "https://github.com/sainnhe/gruvbox-material", name = "gruvbox-material" },
  { src = "https://github.com/preservim/nerdtree", name = "nerdtree" },
  { src = "https://github.com/vim-airline/vim-airline", name = "vim-airline" },
  { src = "https://github.com/jiangmiao/auto-pairs", name = "auto-pairs" },
  { src = "https://github.com/junegunn/fzf", name = "fzf" },
  { src = "https://github.com/junegunn/fzf.vim", name = "fzf.vim" },
  { src = "https://github.com/neovim/nvim-lspconfig", name = "nvim-lspconfig" },
  { src = "https://github.com/sheerun/vim-polyglot", name = "vim-polyglot" },
  },
  { load = true } -- Load plugins immediately because the config below uses their commands and modules.
)

-- ---------- COLOR CONFIG ----------

-- Use 24bit color
vim.opt.termguicolors = true
vim.cmd.colorscheme("gruvbox-material")

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

-- Commenting
-- remap = true lets these compatibility mappings invoke Neovim built-in gc/gcc mappings.
vim.keymap.set("n", "<leader>c<Space>", "gcc", { remap = true, desc = "Toggle comment line" })
vim.keymap.set("v", "<leader>c<Space>", "gc", { remap = true, desc = "Toggle comment selection" })


-- ---------- PLUGIN CONFIG ----------

-- Termdebug
vim.cmd("packadd termdebug")
vim.keymap.set("n", "<C-g>", ":Termdebug <CR>")


-- NERDTree
vim.keymap.set("n", "<C-t>", ":NERDTreeToggle <CR>")

-- " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
-- autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


-- airline
-- vim.g["airline_powerline_fonts"] = 1 -- requires powerline fonts to be installed
vim.g["airline#extensions#tabline#enabled"] = 1 -- enable tabline
vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
vim.g.airline_theme = 'gruvbox_material'


-- fzf
-- (Requires fzf and rg to be installed)
vim.g.fzf_height = "100%"
vim.keymap.set("n", "<C-p>", ":Files <CR>")
vim.keymap.set("n", "<C-f>", ":Rg<SPACE>")


-- LSP stuff
vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
vim.keymap.set('n', '<S-h>', function() vim.lsp.buf.hover() end, opts)
vim.keymap.set('n', '<S-r>', function() vim.lsp.buf.references() end, opts)

local lspconfig = require('lspconfig')
lspconfig.clangd.setup{
  cmd = {
    "clangd",
    "--header-insertion=never",
    "--limit-references=200",
    "--limit-results=50",
    "--background-index",
    "--background-index-priority=normal",
    "-j=10",
    "--pch-storage=memory"
  }
} -- clangd for C/C++; requires clangd installed
