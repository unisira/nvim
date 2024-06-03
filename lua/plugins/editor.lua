return {
  -- Highlight URLs
  { "itchyny/vim-highlighturl", event = "VeryLazy" },
  -- Show and trim trailing whitespaces
  { "jdhao/whitespace.nvim", event = "VeryLazy" },
  -- Auto pairs
  { "echasnovski/mini.pairs", event = "VeryLazy", opts = {} },
  -- Highlight word under cursor
  { "echasnovski/mini.cursorword", event = "VeryLazy", opts = {} },
  -- Auto surround
  { "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
      respect_selection_type = true,
    },
  },
  -- Better text objects
  -- { "echasnovski/mini.ai", event = "VeryLazy" },
  -- Current scope highlight
  {
    "echasnovski/mini.indentscope",
    event = "VeryLazy",
    opts = {
      draw = {
        delay = 20,
        -- Disable animation
        animation = function() return 0 end,
      },
      options = {
        border = "top",
      },
      symbol = "│",
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "NvimTree",
          "Trouble",
          "trouble",
          "lazy",
          "notify",
          "toggleterm",
          "qf",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = false,
      },
      exclude = {
        filetypes = {
          "lazy",
          "help",
          "text",
          "git",
          "trouble",
          "Trouble",
          "terminal",
          "markdown",
          "snippets",
          "gitconfig",
          "dashboard"
        },
        buftypes = { "terminal" },
      },
    },
    main = "ibl",
  },
  -- Better diagnostics/LSP results list
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>xx", "<Cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
    opts = {
      padding = false,
      -- fold_open = "+",
      -- fold_closed = "-",
      -- use_diagnostic_signs = true,
      -- -- Broken on main according to folke, so we have to clear them below too
      -- icons = false,
    },
  },
  -- List and highlight TODO, HACK, BUG, etc.
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble" },
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<Cmd>TodoTrouble<CR>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<Cmd>TodoTrouble keywords=TODO,FIX,FIXME<CR>", desc = "Todo/Fix/Fixme (Trouble)" },
    },
    opts = {
      signs = false,
      highlight = {
        keyword = "bg",
      },
    },
  },
  -- Based fuzzy-finder
  { "junegunn/fzf.vim", lazy = true },
  {
    "ibhagwan/fzf-lua",
    cmd = { "FzfLua" },
    event = "VeryLazy",
    dependencies = { "junegunn/fzf.vim" },
    keys = {
      { "<leader>fs", "<Cmd>FzfLua files<CR>", desc = "Find files" },
      { "<leader>hs", "<Cmd>FzfLua oldfiles<CR>", desc = "Find files in history" },
      { "<leader>bs", "<Cmd>FzfLua buffers<CR>", desc = "Find buffers" },
      { "<leader>r", "<Cmd>FzfLua lsp_references<CR>", desc = "Find symbol references" },
      { "<leader>s", "<Cmd>FzfLua lsp_document_symbols<CR>", desc = "Find symbols" },
      { "<leader>S", "<Cmd>FzfLua lsp_workspace_symbols<CR>", desc = "Find symbols (workspace)" },
      { "<leader>g", "<Cmd>FzfLua grep<CR>", desc = "Grep workspace" },
    },
    opts = {
      winopts = {
        preview = {
          layout = "horizontal",
          border = "noborder",
        },
      },
      files = {
        git_icons = false,
        file_icons = false,
        cwd_prompt = false,
        path_shorten = 256,
        actions = {},
      },
      lsp = {
        symbols = {
          symbol_style = 3,
        },
      },
      fzf_colors = {
        ["fg+"] = { "fg", "Normal" },
        ["bg+"] = { "bg", "Normal" },
        ["pointer"] = { "fg", "FzfLuaDirIcon" },
      },
    },
    config = function(_, opts)
      require("fzf-lua").setup(opts)

      -- NOTE: This is from FloatBorder, but it was being retarded for some reason
      vim.api.nvim_set_hl(0, "FzfLuaBorder", { fg = "#27A1B9" })
    end
  },
}
