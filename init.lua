-- ---------- EDITOR SETTINGS ----------

vim.g.mapleader = "\\" -- Set leader explicitly to the default so <leader> mappings are unambiguous.

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
vim.opt.smartcase  = true   -- ...but be case-sensitive if the search contains an uppercase letter
vim.opt.incsearch  = true   -- Enable incremental search

vim.opt.autoread   = true   -- Enable reloading file on external changes
vim.opt.cursorline = true   -- Highlight current line
vim.opt.signcolumn = "yes"  -- Always draw signcolumn. Used by gitsigns.
vim.opt.mouse      = "nv"   -- Mouse support in normal and visual mode
vim.opt.undofile   = true   -- Persist undo history to disk so it survives closing a file
vim.opt.scrolloff  = 8      -- Keep 8 lines above and below the cursor while scrolling

-- Split config
-- New window always appears down/right of the current one, so vertical and
-- horizontal splits behave consistently.
vim.opt.splitright = true   -- Vertical splits open to the right
vim.opt.splitbelow = true   -- Horizontal splits open below

vim.opt.wrap       = false   -- Disable soft wrapping text at end of screen
-- vim.opt.linebreak  = true   -- Wrap at a whitespace only


-- Install plugins
vim.pack.add({
  { src = "https://github.com/sainnhe/gruvbox-material", name = "gruvbox-material" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua", name = "nvim-tree.lua" },
  { src = "https://github.com/vim-airline/vim-airline", name = "vim-airline" },
  { src = "https://github.com/jiangmiao/auto-pairs", name = "auto-pairs" },
  { src = "https://github.com/lewis6991/gitsigns.nvim", name = "gitsigns.nvim" },
  { src = "https://github.com/sakhnik/nvim-gdb", name = "nvim-gdb" },
  { src = "https://github.com/ibhagwan/fzf-lua", name = "fzf-lua" },
  { src = "https://github.com/sheerun/vim-polyglot", name = "vim-polyglot" },
})

-- ---------- COLOR CONFIG ----------

-- Use 24-bit RGB colors in the terminal
vim.opt.termguicolors = true
vim.cmd.colorscheme("gruvbox-material")


-- vim-polyglot ships MLIR syntax, but its legacy ftdetect misses .mlir files.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.mlir",
  command = "setfiletype mlir",
})


-- Show trailing whitespace and tabs as markers via listchars.
vim.opt.list = true
vim.opt.listchars = { trail = "·", tab = "» " }

-- Hide the markers while typing, restore them when leaving insert mode.
local listchars_group = vim.api.nvim_create_augroup("ListcharsInsert", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
  group = listchars_group,
  command = "set nolist",
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = listchars_group,
  command = "set list",
})


-- ---------- KEY BINDING CONFIG ----------

-- To enable <C-s> and <C-q> in terminal
-- Temporarily disable terminal flow control so <C-s> and <C-q> reach Neovim.
-- Restore the exact previous terminal settings when Neovim exits.
local initial_terminal_settings = vim.fn.system("stty -g"):gsub("%s+$", "")

if vim.v.shell_error == 0 and initial_terminal_settings ~= "" then
  vim.fn.system("stty -ixon")

  vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
      vim.fn.system("stty " .. initial_terminal_settings)
    end,
  })
end

-- Common shortcuts
vim.keymap.set("n", "<C-s>", "<cmd>update<CR>")
vim.keymap.set("n", "<C-q>", "<cmd>qa!<CR>")
vim.keymap.set("n", "<C-x>", "<cmd>bd!<CR>")
vim.keymap.set("n", "<TAB>", "<cmd>bnext<CR>")
vim.keymap.set("n", "<S-TAB>", "<cmd>bprev<CR>")
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

-- Commenting
-- remap = true lets these compatibility mappings invoke Neovim built-in gc/gcc mappings.
vim.keymap.set("n", "<leader>c<Space>", "gcc", { remap = true, desc = "Toggle comment line" })
vim.keymap.set("v", "<leader>c<Space>", "gc", { remap = true, desc = "Toggle comment selection" })


-- ---------- PLUGIN CONFIG ----------

-- nvim-gdb
-- Put the debugger terminal on the left and keep source code on the right.
vim.g.nvimgdb_config_override = {
  termwin_command = "aboveleft vnew",
  codewin_command = "belowright vnew",
}


-- nvim-tree
-- Disable netrw so nvim-tree handles directory browsing.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  git = {
    timeout = 2000,
  },
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        git = true,
        folder_arrow = false,
      },
    },
  },
})

vim.keymap.set("n", "<C-t>", "<cmd>NvimTreeToggle<CR>")


-- airline
-- vim.g["airline_powerline_fonts"] = 1 -- requires powerline fonts to be installed
vim.g["airline#extensions#tabline#enabled"] = 1 -- enable tabline
vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
vim.g.airline_theme = "gruvbox_material"


-- fzf-lua
-- Uses the fzf for matching and rg for text search.
-- Requires fzf and rg installed.
require("fzf-lua").setup({
  winopts = {
    -- Values from 0.0 to 1.0 are fractions of the editor size.
    height = 1.0,
    width = 1.0,
  },
  defaults = {
    file_icons = false,
    git_icons = false,
  },
  files = {
    previewer = "builtin",
  },
  grep = {
    previewer = "builtin",
  },
})

vim.keymap.set("n", "<C-p>", function()
  require("fzf-lua").files()
end, { desc = "Find files" })

vim.keymap.set("n", "<C-f>", function()
  require("fzf-lua").live_grep()
end, { desc = "Search text" })


-- ----------- LSP CONFIG ------------

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<S-h>", vim.lsp.buf.hover, { desc = "Show hover" })
vim.keymap.set("n", "<S-r>", vim.lsp.buf.references, { desc = "Show references" })

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--header-insertion=never",
    "--background-index",
    "--background-index-priority=high",
    "-j=10",
    "--pch-storage=memory",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  root_markers = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git",
  },
}) -- clangd for C/C++; requires clangd installed

vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },
}) -- rust-analyzer for Rust; requires rust-analyzer installed

vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyrightconfig.json",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    ".git",
  },
  settings = {
    python = {
      analysis = {
        diagnosticMode = "openFilesOnly",
        autoImportCompletions = false,    -- Avoid extra completion work for symbols that are not already imported.
        autoSearchPaths = true,           -- Infer common import roots like src/ without per-project config files.
        useLibraryCodeForTypes = true,    -- Keep goto/hover useful for installed packages when type stubs are missing.
        exclude = {
          "**/node_modules",
          "**/__pycache__",
          "**/.*", -- Exclude dot directories such as .git and .venv from workspace scanning.
        },
      },
    },
  },
}) -- pyright for Python; requires pyright-langserver installed

vim.lsp.enable({ "clangd", "rust_analyzer", "pyright" })


-- Temporary workaround to remove unused packages. Should be gone as vim.pack matures
local function pack_clean()
  local unused = {}
  for _, plugin in ipairs(vim.pack.get()) do
    if not plugin.active then
      table.insert(unused, plugin.spec.name)
    end
  end
  if #unused == 0 then
    print("No unused plugins.")
    return
  end
  local choice = vim.fn.confirm("Remove unused plugins: " .. table.concat(unused, ", ") .. "?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.pack.del(unused)
  end
end

vim.keymap.set("n", "<leader>pc", pack_clean)
