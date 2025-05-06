return {
  -- Display key mappings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        {
          mode = { "n", "v" },
          {}
        }
      },
      win = {
        border = "none",
      },
    }
  },

  -- Lists for diagnostics, symbols, etc.
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<Leader>td", "<Cmd>Trouble diagnostics toggle_preview<CR>", desc = "Workspace Diagnostics (Trouble)" },
      { "<Leader>ts", "<Cmd>Trouble symbols toggle_preview<CR>", desc = "Document Symbols (Trouble)" },
      { "<Leader>tl", "<Cmd>Trouble lsp toggle_preview<CR>", desc = "LSP Definitions/References (Trouble)" },
    },
  },

  -- List, highlight, and search TODO, HACK, BUG, etc comments.
  {
    "folke/todo-comments.nvim",
    cmd = "TodoTrouble",
    event = "BufEnter",
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous TODO comment" },
      { "<Leader>tt", "<Cmd>Trouble todo<CR>", desc = "List TODO comments" },
      { "<Leader>tT", "<Cmd>TodoTelescope<CR>", desc = "Search TODO comments" },
    },
    opts = {
      signs = false,
      highlight = {
        keyword = "bg",
      },
    },
  },

  -- Better status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      -- Get the custom components defined in 'extra/lualine.lua'
      local extras = require("extra.lualine");

      require("lualine").setup({
        options = {
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {},
          lualine_c = { extras.pretty_path },
          lualine_x = { "diagnostics" },
          lualine_y = { "location" },
          lualine_z = { "progress" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { extras.pretty_path },
          lualine_x = { "diagnostics" },
          lualine_y = { "location" },
          lualine_z = { "progress" }
        },
        extensions = {
          "quickfix",
          "fugitive",
          "neo-tree",
          "lazy",
          "toggleterm",
          "trouble",
          "fzf"
        },
      })
    end,
  },

  -- Better `vim.notify`
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("notify").setup({
        stages = "static",
        timeout = 1500,
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { border = "single" })
        end,
      })

      -- Set vim.notify to use the new notifications
      vim.notify = require("notify")
    end,
  },

  -- Better UI for some nvim actions
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        border = "single",
      },
      select = {
        border = "single",
      },
    },
  },

  -- Simple file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "muniftanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "NeoTree",
    keys = {
      { "\\", "<Cmd>Neotree reveal<CR>", desc = "Open NeoTree", silent = true },
    },
    opts = {
      close_if_last_window = true,
      source_selector = {
        winbar = true,
      },
      filesystem = {
        window = {
          mappings = {
            ["\\"] = "close_window",
          },
        },
      },
    },
  },

  -- Better UI components
  { "muniftanjim/nui.nvim", lazy = true },

  -- Utility library used by tonnes of other plugins
  { "nvim-lua/plenary.nvim", lazy = true },
}
