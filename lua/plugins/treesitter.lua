return {
  -- Only used for automatic parser installation/compilation.
  -- Highlighting is handled natively via vim.treesitter.start()
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = {
          "c", 
          "cpp", 
          "python", 
          "rust", 
          "lua",
          "json", 
          "yaml", 
          "toml",
          "vim", 
          "vimdoc",
          "markdown", 
          "markdown_inline",
        },
        auto_install = true,
      })
    end,
  },
}
