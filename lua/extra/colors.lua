local M = {}

M.get = function(name)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  local fg = hl.foreground or hl.fg or 0
  local bg = hl.background or hl.bg or 0
  return {
    fg = string.format("#%06x", fg),
    bg = string.format("#%06x", bg),
  }
end

M.get_bg = function(name)
  return M.get(name).bg
end

M.get_fg = function(name)
  return M.get(name).fg
end

local function rgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---@param foreground string Foreground color
---@param background string Background color
---@param alpha number|string Opacity of the foreground color
M.blend = function(foreground, background, alpha)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = rgb(background)
  local fg = rgb(foreground)

  local blend_channel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", blend_channel(1), blend_channel(2), blend_channel(3))
end

return M
