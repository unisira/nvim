local function augroup(name)
  return vim.api.nvim_create_augroup("aucmd_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
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

-- Exit luasnip session on mode-change from select/insert
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*",
  callback = function()
    local luasnip = require("luasnip")
    -- Don't exit this session if it's not in this buffer or we are actively jumping
    if not luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] or luasnip.session.jump_active then
      return
    end

    local event = vim.v.event
    -- Exit this session if we are exiting from a valid auto-completion mode
    if (event.old_mode == "s" and event.new_mode == "n") or event.old_mode == "i" then
      luasnip.unlink_current()
    end
  end
})

-- Highlight trailing whitespace
-- TODO: Move into own file, util/whitespace.lua
-- TODO: Update TrailingWhitespace on colorscheme load depending on
-- if we are in insert-mode or not, but not necessary rn
-- TODO: Grab background color of 'Error' highlight instead
vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "#C53B53" })

vim.api.nvim_create_autocmd("InsertEnter", {
  -- group = augroup("highlight_trailing_ws"),
  callback = function()
    vim.api.nvim_set_hl(0, "TrailingWhitespace", { link = "Whitespace" })
  end
})

vim.api.nvim_create_autocmd("InsertLeave", {
  -- group = augroup("highlight_trailing_ws"),
  callback = function()
    vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "#C53B53" })
  end
})

-- TODO: Language file types are used frequently, put them somewhere so its synced
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("highlight_whitespace"),
  desc = "Highlight trailing whitespace",
  pattern = {
    "rs",
    "lua",
    "cpp",
    "c",
  },
  callback = function(event)
    vim.cmd([[match TrailingWhitespace /\s\+$/]])
  end
})

-- Quit Nvim if there are no normal buffers
-- vim.api.nvim_create_autocmd("BufEnter", {
--   desc = "Ignore non-normal buffers on quit",
--   callback = function()
--     vim.notify("Running quit checker")
--     local normal_count = 0
--     -- Check all open buffers if there are any normal buffers
--     for _, bufname in pairs(vim.api.nvim_list_bufs()) do
--       if vim.api.nvim_buf_is_loaded(bufname) then
--         local bt = vim.api.nvim_buf_get_option(bufname, "buftype")
--         vim.notify("Buftype: " .. bt)
--         if bt == "" or bt == "normal" then
--           normal_count = normal_count + 1
--         end
--       end
--     end
--     vim.notify("Normal count: " .. normal_count)
--     if normal_count < 1 then
--       vim.cmd("qall")
--     end
--   end
-- })
