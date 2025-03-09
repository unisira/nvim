vim.loader.enable()

if vim.g.neovide then
  -- Disable animations
  vim.o.guifont = "FiraMono Nerd Font (Fixed):h12"
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_scroll_animation_length = 0
  -- Make the title bar colour match whatever the background color is
  vim.g.neovide_title_background_color = string.format(
      "%x",
      vim.api.nvim_get_hl(0, {id=vim.api.nvim_get_hl_id_by_name("Normal")}).bg
  )
end

require("config")
require("spec")

vim.cmd("color ayu")
