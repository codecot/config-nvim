-- ~/.config/nvim/lua/options.lua

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- UI improvements
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.showmode = false -- Hide mode in command line (lualine shows it)

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.lazyredraw = true

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.pumheight = 10 -- Limit popup menu height

-- File handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"

-- Mouse and clipboard
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- Split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Folding
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

-- Whitespace visualization
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", trail = "·", extends = "⟩", precedes = "⟨" }

