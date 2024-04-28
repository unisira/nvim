local M = {}

M.color = function(name)
  local hl = vim.api.nvim_get_hl_by_name(name, true)
  local fg = hl.foreground or hl.fg
  local bg = hl.background or hl.bg
  return {
    fg = string.format("#%06x", fg),
    bg = string.format("#%06x", bg),
  }
end

return M
