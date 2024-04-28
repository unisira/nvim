return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      indent = { enable = true },
      highlight = {
        enable = true,
        disable = function(language, buf)
          -- TODO: Move into util/options, need to localize all custom options
          return vim.api.nvim_buf_line_count(buf) > 5000
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

