local colors = require("extra.colors")

local themes = {
  { "sainnhe/edge", lazy = true },
  { "sainnhe/sonokai", lazy = true },
  { "sainnhe/everforest", lazy = true },
  { "rrethy/base16-nvim", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "folke/tokyonight.nvim", lazy = true },
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
}

-- Options that will be passed through lazy.nvim's `opts`
local colorscheme_opts = {
  ["ellisonleao/gruvbox.nvim"] = {
    italic = {
      strings = false,
      comments = false,
      operators = false,
      folds = false,
    },
  },
  ["rebelot/kanagawa.nvim"] = {
    commentStyle = { italic = false },
    keywordStyle = { italic = false },
  },
  ["folke/tokyonight.nvim"] = {
    styles = {
      comments = { italic = false },
      keywords = { italic = false },
    },
    on_highlights = function(hl, colors)
      -- Add window separators
      hl.NvimTreeWinSeparator = {
        fg = colors.bg,
        bg = colors.bg,
      }
    end,
  },
  ["catppuccin/nvim"] = {
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
  },
}

-- Insert any custom configurations, overengineering 101
for _, theme in pairs(themes) do
  local theme_name = theme[1]

  if colorscheme_opts[theme_name] then
    theme.opts = vim.tbl_deep_extend("force", colorscheme_opts[theme_name], theme.opts or {})
  end
end

return themes
