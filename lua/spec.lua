local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Do not load performance intensize plugins
local clean = true

-- NOTE: Some performance intensive plugins listed below:
-- treesitter: Now disabled on files > 25k LOC
-- whitespace:
-- - Performs a regex on an entire file?
-- - Can be re-implemented with :match [highlight] /\s\+$/ with no performance loss
-- indent-blankline:
-- - Their 'scope' feature is incredibly slow, they claim it is not their problem but a treesitter
--   issue, but they also claim it is only ran on the visible lines which means they're retards and can't
--   accept their code is ass, mini.indentscope is a p replacement
local disabled = clean and {
  -- { "hrsh7th/nvim-cmp", enabled = false },
  -- { "neovim/nvim-lspconfig", enabled = false },
  -- { "nvim-treesitter/nvim-treesitter", enabled = false }, -- SLOW but can be disabled for large files (1s loading timeout?)
  -- { "echasnovski/mini.indentscope", enabled = false }, -- SLOW but can be disabled for large files (1s loading timeout?)
  -- { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "jdhao/whitespace.nvim", enabled = false },
} or {}

require("lazy").setup({
  spec = {
    -- undo tree and a debugger, then i'm happy.
    -- multiple cursors fixed properly would be nice
    { import = "plugins" },
    -- Disable some performance intensive plugins if loaded clean
    { unpack(disabled) },
  },
  checker = {
    -- Don't automatically check for updates
    enabled = false,
    notify = false,
  },
  ui = {
    border = "single",
    title = "Plugin Manager",
    title_pos = "center",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
  performance = {
    rtp = {
      -- Disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
