return {
  -- Display key mappings
  { "folke/which-key.nvim", config = true },
  -- Easy built-in terminals
  {
    'akinsho/toggleterm.nvim',
    event = "VeryLazy",
    opts = {
      -- size = 16,
      open_mapping = "<C-\\>",
      -- hide_numbers = true,
      -- shade_filetypes = {},
      -- shade_terminals = true,
      -- start_in_insert = true,
      -- persist_size = true,
      -- persist_mode = true,
      -- direction = "horizontal",
      -- shell = vim.o.shell,
      -- auto_scroll = true,
    },
  },
}
