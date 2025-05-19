local colors = require("extra.colors")

local function augroup(name)
  return vim.api.nvim_create_augroup("aucmd_" .. name, { clear = true })
end

-- Temporary fix for telescope UI
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopeFindPre",
  callback = function()
    vim.opt_local.winborder = "none"
    vim.api.nvim_create_autocmd("WinLeave", {
      once = true,
      callback = function()
        vim.opt_local.winborder = "rounded"
      end,
    })
  end,
})

-- Update custom colorscheme options, I hate color schemes
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()

    local set_hl = vim.api.nvim_set_hl
    -- Use generic filename highlights instead of underlining
    set_hl(0, "NvimTreeDiagnosticErrorFileHL", { link = "DiagnosticError" })
    set_hl(0, "NvimTreeDiagnosticWarnFileHL", { link = "DiagnosticWarn" })
    set_hl(0, "NvimTreeDiagnosticInfoFileHL", { link = "DiagnosticInfo" })
    set_hl(0, "NvimTreeDiagnosticHintFileHL", { link = "DiagnosticHint" })
    -- Make open folder's icon's bold
    set_hl(0, "NvimTreeFolderArrowOpen", { link = "Bold" })

    -- Define diagnostic line highlights to be the same color as the virtual text background
    vim.api.nvim_set_hl(0, "DiagnosticLineError", { bg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextError" }).bg });
    vim.api.nvim_set_hl(0, "DiagnosticLineWarn", { bg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextWarn" }).bg });
    vim.api.nvim_set_hl(0, "DiagnosticLineInfo", { bg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextInfo" }).bg });
    vim.api.nvim_set_hl(0, "DiagnosticLineHint", { bg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextHint" }).bg });

    -- Make the sign column and fold column all use the background color
    -- vim.api.nvim_set_hl(0, "SignColumn", { link = "Normal" })
    -- vim.api.nvim_set_hl(0, "FoldColumn", { link = "Normal" })
  end,
})

-- Open a file picker if neovim was launched with no target file
-- TODO: Make this check if it's a file, and not a directory
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argv(0) == "" then
      require("telescope.builtin").find_files()
    end
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end,
})

-- Resize all windows automatically
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("win_resize"),
  desc = "Auto-resize windows",
  command = "wincmd =",
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  desc = "Close buffers on <q>",
  pattern = {
    "checkhealth",
    "toggleterm",
    "lspinfo",
    "notify",
    "netrw",
    "query",
    "help",
    "qf",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "#C53B53" })
