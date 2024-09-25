return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      highlight = {
        enable = true,
        disable = function(_, buf)
          -- Disable treesitter for large files, This might've been cuased by indentation
          return vim.api.nvim_buf_line_count(buf) > 7500
        end,
      },
      ensure_installed = {
        "c",
        "cpp",
        "rust",
        "lua",
        "luap",
        "luadoc",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

