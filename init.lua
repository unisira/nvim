vim.loader.enable()

local version = vim.version

require("config")
require("spec")

vim.cmd("color catppuccin")
