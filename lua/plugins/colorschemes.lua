local themes = {
  { 'projekt0n/github-nvim-theme', lazy = true },
  { "navarasu/onedark.nvim", lazy = true },
  { "sainnhe/edge", lazy = true },
  { "sainnhe/sonokai", lazy = true },
  { "sainnhe/gruvbox-material", lazy = true },
  { "sainnhe/everforest", lazy = true },
  { "EdenEast/nightfox.nvim", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "olimorris/onedarkpro.nvim", lazy = true },
  { "marko-cerovac/material.nvim", lazy = true },
  { "folke/tokyonight.nvim", lazy = true },
  { "mellow-theme/mellow.nvim", lazy = true },
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
    color_overrides = {
      mocha = {
        base = "#000000",
        mantle = "#000000",
        crust = "#000000",
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
