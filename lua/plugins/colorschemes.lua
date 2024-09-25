local themes = {
  { "sainnhe/edge", lazy = true },
  { "sainnhe/sonokai", lazy = true },
  { "sainnhe/everforest", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "rrethy/base16-nvim", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "folke/tokyonight.nvim", lazy = true },
  { "oahlen/iceberg.nvim", lazy = true },
  { "niyabits/calvera-dark.nvim", lazy = true },
  { "ayu-theme/ayu-vim", lazy = true },
}

-- Options that will be passed through lazy.nvim's `opts`
local colorscheme_opts = {
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
    no_italic = true,
    no_underline = true,
    transparent_background = true,
    color_overrides = {
      mocha = {
        base = "#181823",
        -- Highlights statusline, nvim-tree etc. (1F1F2F is good for a brighter statusline etc)
        mantle = "#181823",
        crust = "#212130",
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
