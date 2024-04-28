local map = vim.keymap.set

map({ "n", "x" }, ";", ":", { desc = "Enter command" })

-- Do not include white space characters when using $ in visual mode
map("x", "$", "g_")

-- Save current buffer
map("n", "<Leader>w", "<Cmd>up<CR>", { silent = true, desc = "Save buffer" })
-- Save all buffers
map("n", "<Leader>W", "<Cmd>wa<CR>", { silent = true, desc = "Save all buffer" })

-- Save (if modified) and quit
map("n", "<Leader>q", "<Cmd>x<CR>", { silent = true, desc = "Save and quit current buffer" })
-- Save and quit all opened buffers
map("n", "<Leader>Q", "<Cmd>xa<CR><Cmd>qa<CR>", { silent = true, desc = "Save all and quit" })

-- Insert empty line above/below without moving cursor
map("n", "<Space>o", "m`o<ESC>``", { desc = "Insert line below" })
map("n", "<Space>O", "m`O<ESC>``", { desc = "Insert line above" })

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move Lines
map("n", "<A-Down>", "<Cmd>m .+1<CR>==", { desc = "Move Line Down" })
map("n", "<A-Up>", "<Cmd>m .-2<CR>==", { desc = "Move Line Up" })
map("i", "<A-Down>", "<Esc><Cmd>m .+1<CR>==gi", { desc = "Move Line Down" })
map("i", "<A-Up>", "<Esc><Cmd>m .-2<CR>==gi", { desc = "Move Line Up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move Line Down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move Line Up" })

-- Switch windows
map("n", "<C-Up>", "<C-W>k", { desc = "Go to upper window" })
map("n", "<C-Down>", "<C-W>j", { desc = "Go to lower window" })
map("n", "<C-Left>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-Right>", "<C-W>l", { desc = "Go to right window" })

-- Resize windows
map("n", "<A-.>", "<Cmd>:vertical res +2<CR>", { silent = true, desc = "Increase window width" })
map("n", "<A-,>", "<Cmd>:vertical res -2<CR>", { silent = true, desc = "Decrease window width" })
map("n", "<A-=>", "<Cmd>:res +2<CR>", { silent = true, desc = "Increase window height" })
map("n", "<A-->", "<Cmd>:res -2<CR>", { silent = true, desc = "Decrease window height" })

-- Go to start or end of line easier
map({ "n", "x" }, "H", "^")
map({ "n", "x" }, "L", "g_")

-- Continuous visual shifting (does not exit Visual mode)
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Clear search with <Esc>
-- map({ "i", "n" }, "<Esc>", "<Cmd>noh<CR><Cmd>let @/=''<CR><Esc>", { silent = true, desc = "Escape and Clear hlsearch" })
map({ "i", "n" }, "<Esc>", "<Esc><Cmd>noh<CR>", { desc = "Escape and Clear hlsearch" })

-- Open lazy window
map("n", "<Leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Copy entire buffer.
map("n", "<Leader>y", "<Cmd>%yank<CR>", { desc = "Yank entire buffer" })

-- Replace visual selection with text in register, but not contaminate the register
map("x", "p", '"_c<Esc>p')

-- Go to beginning of command in command-line mode
map("c", "<C-A>", "<HOME>")

-- New file
map("n", "<Leader>n", "<Cmd>enew<CR>", { desc = "New File" })

-- Tabs
map("n", "<Leader><Tab>l", "<Cmd>tablast<CR>", { desc = "Last Tab" })
map("n", "<Leader><Tab>f", "<Cmd>tabfirst<CR>", { desc = "First Tab" })
map("n", "<Leader><Tab><Tab>", "<Cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<Leader><Tab>]", "<Cmd>tabnext<CR>", { desc = "Next Tab" })
map("n", "<Leader><Tab>d", "<Cmd>tabclose<CR>", { desc = "Close Tab" })
map("n", "<Leader><Tab>[", "<Cmd>tabprevious<CR>", { desc = "Previous Tab" })

-- Use Esc to quit builtin terminal
-- Retarded neovim devs can't make vim.keymap.set work for tmap's I guess
vim.cmd(":tmap <Esc> <C-\\><C-n>")
