return {
  { "sainnhe/edge", lazy = true },
  { "sainnhe/sonokai", lazy = true },
  { "sainnhe/everforest", lazy = true },
  { "rrethy/base16-nvim", lazy = true },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
      },
    }
  },
  {
    "shatur/neovim-ayu",
    lazy = true,
    config = function()
      require('ayu').setup({
        overrides = {
          Normal = { bg = "#020202" },
          NormalFloat = { bg = "#020202" },
          ColorColumn = { bg = "#020202" },
          SignColumn = { bg = "#020202" },
          FoldColumn = { bg = "#020202" },
          WinSeparator = {
            fg = "#1A1A1A",
            bg = "#020202"
          },
          -- Function = { fg = "#E6B450" },
          -- Treesitter
          ["@variable"] = { fg = "#DEDEDE" },
          ["@variable.member"] = { link = "@variable" },
          ["@property"] = { link = "@variable" },
          ["@type.builtin"] = { link = "@type" },
          -- LSP
          ["@lsp.type.macro"] = { link = "@constant" },
          ["@lsp.type.variable"] = { link = "@variable" },
          ["@lsp.type.property"] = { link = "@variable" },
        }
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      no_bold = true,
      no_italic = true,
      no_underline = true,
      transparent_background = false,
      color_overrides = {
        mocha = {
          -- base = "#080813",
          -- -- Highlights statusline, nvim-tree etc. (1F1F2F is good for a brighter statusline etc)
          -- mantle = "#131320",
          -- crust = "#131320",
          base = "#030303",
          mantle = "#030303",
          crust = "#13131D",
        },
      },
      integrations = {
        telescope = {
          enabled = true,
        },
      },
    }
  },
}
