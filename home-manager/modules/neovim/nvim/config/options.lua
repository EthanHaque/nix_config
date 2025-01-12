local indent = 4

-- TODO: come back to this line
vim.opt.termguicolors = true -- enable 24-bit RGB colors

vim.cmd([[
  filetype plugin indent on
]])


vim.opt.backspace = { "eol", "start", "indent" } -- allow backspacing over everything in insert mode
vim.opt.clipboard = "unnamedplus"                -- allow neovim to access the system clipboard
vim.opt.encoding = "utf-8"                       -- Internal encoding used by Vim
vim.opt.fileencoding = "utf-8"                   -- Encoding used when saving files
vim.opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
vim.opt.syntax = "enable"

-- indention
vim.opt.autoindent = true    -- auto indentation
vim.opt.expandtab = true     -- convert tabs to spaces
vim.opt.shiftwidth = indent  -- the number of spaces inserted for each indentation
vim.opt.smartindent = true   -- make indenting smarter
vim.opt.softtabstop = indent -- when hitting <BS>, pretend like a tab is removed, even if spaces
vim.opt.tabstop = indent
vim.opt.shiftround = true    -- use multiple of shiftwidth when indenting with "<" and ">"

-- search
vim.opt.hlsearch = true   -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true  -- smart case
vim.opt.wildignore = vim.opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
vim.opt.wildmenu = true   -- make tab completion for files/buffers act like bash

-- ui
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true -- highlight the current line
vim.opt.laststatus = 2    -- only the last window will always have a status line
vim.opt.lazyredraw = true -- don"t update the display while executing macros
vim.opt.list = true
-- You can also add "space" or "eol", but I feel it"s quite annoying
vim.opt.listchars = {
  tab = "┊ ",
  trail = "·",
  extends = "»",
  precedes = "«",
  nbsp = "×",
}

-- Removes command line from bottom except when recording macro.
vim.cmd [[ autocmd RecordingLeave * set cmdheight=0 ]]
vim.cmd [[ autocmd RecordingEnter * set cmdheight=1 ]]

vim.opt.scrolloff = 18     -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 10 -- minimal number of screen columns to keep to the left and right (horizontal) of the cursor if wrap is `false`
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.splitbelow = true  -- open new split below
vim.opt.splitright = true  -- open new split to the right
vim.opt.wrap = false       -- display a long line

-- backups
vim.opt.backup = false      -- create a backup file
vim.opt.swapfile = false    -- creates a swapfile
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- autocomplete
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
vim.opt.shortmess = vim.opt.shortmess + {
  c = true,
}                        -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"

vim.opt.showmode = true  -- perfomance
-- remember N lines in history
vim.opt.history = 100    -- keep 100 lines of history
vim.opt.redrawtime = 1500
vim.opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 100 -- signify default updatetime 4000ms is not good for async update

-- persistent undo
-- Don"t forget to create folder $HOME/.local/share/nvim/undo
local undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true -- enable persistent undo
vim.opt.undodir = undodir
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- fold
vim.opt.foldmethod = "marker"
vim.opt.foldlevel = 99
