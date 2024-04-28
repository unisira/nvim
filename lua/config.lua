vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- TODO: Actually implement this in autocmds.lua
-- Disable auto-formatting on save
vim.g.autoformat = true

vim.g.loaded_perl_provider = 0  -- Disable perl provider
vim.g.loaded_ruby_provider = 0  -- Disable ruby provider
vim.g.loaded_node_provider = 0  -- Disable node provider
vim.g.did_install_default_menus = 1  -- do not load menu

-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
-- related to checking files inside compressed files)
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1

-- Do not load the tutor plugin
vim.g.loaded_tutor_mode_plugin = 1

-- Do not load tohtml.vim
vim.g.loaded_2html_plugin = 1

-- Disable sql omni completion, it is broken.
vim.g.loaded_sql_completion = 1

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.fileformats="unix,dos" -- Fileformats to use for new files
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = false -- Don't use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.laststatus = 2
opt.mouse = "nica"
opt.mousemodel = "popup"
opt.mousescroll = "ver:3,hor:0"
opt.number = true
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = false
opt.scrolloff = 5 -- Minimum lines to keep above and below cursor
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.softtabstop = 4 -- Number of spaces in tab when editing
opt.shiftwidth = 4 -- Number of spaces in tab when auto-indenting
opt.shiftround = true -- Round indent
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.tabstop = 4 -- Number of spaces tabs count for
opt.timeoutlen = 300
opt.termguicolors = true -- True color support
opt.ruler = false
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.winblend = 0 -- Disable transparency for floating windows
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.wrap = false
opt.fillchars = {
  foldopen = "+",
  foldclose = "-",
  foldsep = " ",
  fold = " ",
  diff = "╱",
  eob = " ",
}

-- NOTE: indent-blankline is super slow with scope enabled
-- NOTE:
-- Enable list if you would like to have characters instead of blocks for
-- trailing whitespace
opt.list = false
opt.listchars:append({
	-- tab = "  ",
	-- lead = "·",
	trail = "·",
})

-- Load auto-commands and keymaps now that everything is initialized
require("autocmds")
require("keymaps")
-- Use spaces and 2-width tabs for lua files
require("util.filetype").tabstyle({
  lua = {
    spaces = true,
    width = 2,
  },
  rust = {
    spaces = false,
    width = 4,
  }
})

