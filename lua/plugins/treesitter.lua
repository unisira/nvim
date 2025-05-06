return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    cmd = {
      "TSInstall",
      "TSUpdate",
      "TSUpdateSync",
    },
    opts = {
      indent = { enable = true },
      highlight = { enable = true },
      ensure_installed = {
        "c",
        "cpp",
        "rust",
        "lua",
        "luap",
        "luadoc",
        "markdown",
        "markdown_inline",
        "python",
        "vim",
        "vimdoc",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Treesitter-assisted navigation and selection objects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    enabled = true,
    textobjects = {
      select = {
        enable = true,
        kemaps = {
          ["af"] = { query = "@function.outer", desc = "Select function (outer)"},
          ["if"] = { query = "@function.inner", desc = "Select function (inner)"},
          ["ac"] = { query = "@class.outer", desc = "Select class (outer)"},
          ["ic"] = { query = "@class.inner", desc = "Select class (inner)"},
        }
      },
      move = {
        enable = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
          ["[A"] = "@parameter.inner"
        },
      }
    }
  }
}


