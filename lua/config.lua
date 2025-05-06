-- Remap <leader> to ','
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- What?
vim.g.autoformat = true

-- Don't show the NetRW header if used
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.g.loaded_perl_provider = 1  -- Disable perl provider
vim.g.loaded_ruby_provider = 1  -- Disable ruby provider
vim.g.loaded_node_provider = 1  -- Disable node provider
vim.g.did_install_default_menus = 1  -- do not load menu

-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
-- related to checking files inside compressed files)
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_sql_completion = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

local opt = vim.opt

opt.clipboard = "unnamedplus" -- Yank to clipboard

-- Identation:
opt.expandtab = false -- Do not expand tab characters to spaces
opt.tabstop = 2 -- The number of whitespace characters a <Tab> is rendered as
opt.shiftwidth = 2 -- The number of whitespace characters to insert when indenting
opt.shiftround = true -- Round indentation levels to a multiple of `shiftwidth`
opt.smartindent = true -- Insert indents automatically
opt.expandtab = false -- Don't use spaces instead of tabs

-- UI:
opt.number = true -- Show line number
opt.relativenumber = false -- Who fucking uses this?
opt.cursorline = true -- Enable highlighting of the current line
opt.laststatus = 2 -- Per-buffer status-line
opt.mouse = "a" -- Enable mouse mode in all modes
opt.mousemodel = "popup"
opt.mousescroll = "ver:3,hor:0"
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.splitkeep = "screen" -- Split windows will open with the same screen-wide text
opt.signcolumn = "yes" -- Make signcolumn persist
opt.scrolloff = 5 -- Minimum lines to keep above and below cursor
opt.pumheight = 10 -- Maximum number of entries in a popup (completion window, etc.)
opt.showmode = false
opt.showcmd = false
opt.ruler = false
opt.wrap = false -- Don't wrap text
opt.winborder = "single"

-- TODO: Fix that retarded fucking nvim-cmp bug where it jumps to the last auto-complete selection
opt.formatoptions = "jcroqlnt" -- Basic auto-formatting options while editing
opt.timeoutlen = 300 -- Lower timeout for keymap inputs (i.e. <leader> will timeout after 300ms and do nothing)
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.ignorecase = true -- Ignore case in searches (where `smartcase` doesn't apply)
opt.smartcase = true -- Don't ignore case with multiple capitals
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.termguicolors = true -- True color support
opt.undofile = true -- Enable undo
opt.updatetime = 200 -- Decreased update time for quicker swapfile updates and CursorHold triggers
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode

-- NOTE: Where/what are these used for?
opt.fillchars = {
  foldopen = "+",
  foldclose = "-",
  foldsep = " ",
  fold = " ",
  diff = "╱",
  eob = " ",
}

-- NOTE:
-- Enable list if you would like to have characters instead of blocks for
-- trailing whitespace
opt.list = false
opt.listchars:append({
	-- tab = "  ",
	-- lead = "·",
	-- trail = "·",
})

-- Load auto-commands and keymaps now that everything is initialized
require("autocmds")
require("keymaps")
-- Use spaces and 2-width tabs for lua files
require("extra.filetype").style({
  lua = {
    spaces = true,
    width = 2,
    comment = "-- %s",
  },
  rust = {
    spaces = true,
    width = 4,
    comment = "// %s",
  },
  c = {
    spaces = false,
    width = 4,
    comment = "// %s",
  },
  cpp = {
    spaces = false,
    width = 4,
    comment = "// %s",
  },
})

