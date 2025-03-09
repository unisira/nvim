return {
  -- Display key mappings
  { "folke/which-key.nvim", opts = {} },
  -- Icons for everything
  { "nvim-tree/nvim-web-devicons", lazy = true },
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
  -- Easy built-in terminals
  {
    'akinsho/toggleterm.nvim',
    event = "VeryLazy",
    opts = {
      open_mapping = "<C-\\>",
    },
  },
  -- FZF implementation for telescope
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
  -- Fuzzy finder for files, symbols, etc.
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    branch = "0.1.x",
    dependencies = {
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
        }
      })
      -- Use FZF, it's better
      require("telescope").load_extension("fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<Leader>f", builtin.find_files, { desc = "Search files" })
      vim.keymap.set("n", "<Leader>F", builtin.find_files, { desc = "Browse files" })
      vim.keymap.set("n", "<Leader>o", builtin.oldfiles, { desc = "Search recent files" })
      vim.keymap.set("n", "<Leader>g", builtin.live_grep, { desc = "Search by grep" })
      vim.keymap.set("n", "<Leader>h", builtin.help_tags, { desc = "Search help-tags" })
      vim.keymap.set("n", "<Leader>c", builtin.colorscheme, { desc = "Search colorschemes" })
      vim.keymap.set("n", "<Leader>r", builtin.lsp_references, { desc = "Search references" })
      vim.keymap.set("n", "<Leader>s", builtin.lsp_document_symbols, { desc = "Search symbols" })
      vim.keymap.set("n", "<Leader>S", builtin.lsp_workspace_symbols, { desc = "Search workspace symbols" })
      vim.keymap.set("n", "<Leader>d", builtin.diagnostics, { desc = "Search diagnostics" })
    end,
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
          "nvim-tree",
          "lazy",
          "toggleterm",
          "trouble",
          "fzf"
        },
      })
    end,
  },
  -- File explorer, here because I can't get rid of it
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<Space>s", "<Cmd>NvimTreeToggle<CR>", desc = "Open file explorer", mode = "n" },
    },
    config = function()
      require("nvim-tree").setup({
        hijack_cursor = true,
        sort_by = "name",
        renderer = {
          add_trailing = false,
          root_folder_label = function(path)
            return "Neo-tree"
          end,
          highlight_modified = "name",
          highlight_diagnostics = "name",
          indent_markers = {
            enable = true,
            icons = {
              corner = "└ ",
              edge = "│ ",
              none = "  ",
            },
          },
          icons = {
            show = {
              folder_arrow = false,
            },
          },
        },
        update_focused_file = {
          enable = true,
        },
        modified = {
          enable = true,
          show_on_dirs = false,
        },
        diagnostics = {
          enable = true,
          show_on_dirs = false,
          severity = {
            min = vim.diagnostic.severity.WARNING,
            max = vim.diagnostic.severity.ERROR,
          },
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        git = {
          enable = false,
        },
      })
    end,
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
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO comments" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous TODO comments" },
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
  -- Breadcrumbs
  {
    "utilyre/barbecue.nvim",
    event = "BufEnter",
    version = "*",
    dependencies = {
      "smiteshp/nvim-navic",
    },
    keys = {
      { "<Leader>bb", function() require("barbecue.ui").toggle() end, desc = "Toggle breadcrumbs" },
      { "<Leader>bo", function() require("barbecue.ui").navigate(-1) end, desc = "Move to previous scope" },
    },
    opts = {}
  }
}
