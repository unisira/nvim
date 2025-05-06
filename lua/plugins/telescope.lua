return {
  -- FZF implementation for telescope
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },

  -- Fuzzy finder for files, symbols, etc.
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dpendencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
          },
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        },
        pickers = {
          colorscheme = {
            enable_preview = true,
          }
        }
      })

      require("telescope").load_extension("fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<Leader>f", builtin.find_files, { desc = "Search files" })
      vim.keymap.set("n", "<Leader>o", builtin.oldfiles, { desc = "Search recent files" })
      vim.keymap.set("n", "<Leader>g", builtin.live_grep, { desc = "Search by grep" })
      vim.keymap.set("n", "<Leader>h", builtin.help_tags, { desc = "Search help-tags" })
      vim.keymap.set("n", "<Leader>c", builtin.colorscheme, { desc = "Search colorschemes" })
      vim.keymap.set("n", "<Leader>r", builtin.lsp_references, { desc = "Search references" })
      vim.keymap.set("n", "<Leader>s", builtin.lsp_document_symbols, { desc = "Search symbols" })
      vim.keymap.set("n", "<Leader>S", builtin.lsp_workspace_symbols, { desc = "Search workspace symbols" })
      vim.keymap.set("n", "<Leader>d", builtin.diagnostics, { desc = "Search diagnostics" })
      vim.keymap.set('n', '<Leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'Search in current buffer' })
    end,
  },
}

