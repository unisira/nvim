local lualine = require("util.lualine")

return {
  -- LSP progress indicators
  { "j-hui/fidget.nvim", opts = {} },
  -- Better `vim.notify`
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("notify").setup({
        -- Use character icons
        icons = {
          DEBUG = "!",
          ERROR = "!",
          INFO = "!",
          TRACE = "!",
          WARN = "!",
        },
        -- Animation style
        stages = "static",
        -- Default timeout for notifications
        timeout = 1500,
        -- Use static borders
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
  -- Custom buffer/tab line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<C-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
      { "<C-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
      { "[b", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
      { "]b", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
    },
    opts = {
      options = {
        numbers = "none",
        buffer_close_icon = "x",
        modified_icon = "●",
        close_icon = "x",
        left_trunc_marker = "..",
        right_trunc_marker = "..",
        show_buffer_icons = false,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diag)
          return "! " .. count
        end,
        sort_by = "id",
        offsets = {
          {
            filetype = "NvimTree",
            highlight = "Directory",
            text = "Neo-tree",
            text_align = "left",
          },
        },
      },
    },
  },
  -- Custom status-line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        globalstatus = false,
        icons_enabled = false,
        section_separators = "",
        component_separators = "",
        disabled_filetypes = {},
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { lualine.root, lualine.pretty_path, "diagnostics"},
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "location" },
        lualine_z = { "progress" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { lualine.pretty_path },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "location" },
        lualine_z = { "progress" }
      },
      -- winbar = {
      --   lualine_c = { lualine.pretty_path },
      -- },
      -- inactive_winbar = {
      --   lualine_c = { lualine.pretty_path },
      -- },
      extensions = {
        "quickfix",
        "fugitive",
        "nvim-tree",
        "lazy",
        "toggleterm",
        "trouble",
        "fzf"
      },
    },
  },
  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<space>s", "<Cmd>NvimTreeToggle<CR>", desc = "Toggle Nvim-Tree", mode = "n" },
    },
    config = function()
      require("nvim-tree").setup({
        hijack_cursor = true,
        sort_by = "name",
        renderer = {
          add_trailing = false,
          root_folder_label = false,
          highlight_modified = "name",
          highlight_diagnostics = "name",
          icons = {
            show = {
              file = false,
              folder = false,
              folder_arrow = false,
              diagnostics = false,
            },
          },
          indent_markers = {
            enable = true,
            icons = {
              corner = "└ ",
              edge = "│ ",
              none = "  ",
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
          icons = {
            hint = "●",
            info = "●",
            warning = "●",
            error = "●",
          },
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

      local set_hl = vim.api.nvim_set_hl
      -- Windows terminal doesn't properly handle underline stuff, use text highlights instead
      set_hl(0, "NvimTreeDiagnosticErrorFileHL", { link = "DiagnosticError" })
      set_hl(0, "NvimTreeDiagnosticWarnFileHL", { link = "DiagnosticWarn" })
      set_hl(0, "NvimTreeDiagnosticInfoFileHL", { link = "DiagnosticInfo" })
      set_hl(0, "NvimTreeDiagnosticHintFileHL", { link = "DiagnosticHint" })
      -- Make open folder's icon's bold
      set_hl(0, "NvimTreeFolderArrowOpen", { link = "Bold" })
    end,
  },
  -- Better LSP UI
  -- {
  --   "nvimdev/lspsaga.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     ui = {
  --       border = "single",
  --       devicon = false,
  --       foldericon = false,
  --       expand = "+",
  --       collapse = "-",
  --     },
  --     hover = {
  --       max_width = 0.5,
  --       max_height = 0.05,
  --     },
  --     -- TODO
  --     -- TODO
  --     -- TODO
  --     -- TODO
  --     -- TODO
  --   },
  -- },
  -- Nice dashboard
  -- {
  --   "nvimdev/dashboard-nvim",
  --   event = "VimEnter",
  --   opts = {
  --     -- TODO
  --   },
  -- }
}
