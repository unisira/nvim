local M = {}

local function normalize_path(path)
  if path:sub(1, 1) == "~" then
    local home = vim.uv.os_homedir()
    if home:sub(-1) == "\\" or home:sub(-1) == "/" then
      home = home:sub(1, -2)
    end
    path = home .. path:sub(2)
  end
  path = path:gsub("\\", "/"):gsub("/+", "/")
  return path:sub(-1) == "/" and path:sub(1, -2) or path
end

local function get_root()
  return vim.uv.cwd()
end

local function get_cwd()
  local path = get_root()
  local root = vim.uv.fs_realpath(path) or path
  return normalize_path(root)
end

local function format_ll(component, text, hl_group)
  if not hl_group or hl_group == "" then
    return text
  end

  component.hl_cache = component.hl_cache or {}

  local highlight = component.hl_cache[hl_group]
  if not highlight then
    local utils = require("lualine.utils.utils")
	local group = utils.extract_highlight_colors(hl_group, "fg")
	highlight = component:create_hl({ fg = group }, "lualine_" .. hl_group)
    component.hl_cache[hl_group] = highlight
  end
  return component:format_hl(highlight) .. text .. component:get_default_hl()
end

-- TODO: Add these options into a `require("util").setup({ .. })` call
-- or `require("util.lualine").setup({ .. })`, or both, who cares brah
--
-- opts = vim.tbl_extend("force", {
--   relative = "cwd",
--   modified_hl = "Type",
--   directory_hl = "",
--   filename_hl = "Bold",
--   modified_sign = "",
-- }, opts or {})

-- Same as NvimTreeModifiedIcon, I should probably define some global colours for things like these,
-- plugins will define their own, so it would be nice to have our own
M.modified_hl = "Type"
M.filename_hl = "Normal"
M.directory_hl = "Comment"
M.modified_sign = ""
M.relative = "cwd"

M.pretty_path = {
  function(self)
    if vim.g.statusline_winid ~= nil then
      vim.notify(vim.inspect(vim.g.statusline_winid))
	end
    local path = vim.fn.expand("%:p")
    if path == "" then
      return ""
    end

    local root = get_root()
    local cwd = get_cwd()
    if M.relative == "cwd" and path:find(cwd, 1, true) == 1 then
      path = path:sub(#cwd + 2)
    else
      path = path:sub(#root + 2)
    end

    local sep = package.config:sub(1, 1)
    local parts = vim.split(path, "[\\/]")
    if #parts > 3 then
      parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
    end

    if M.modified_hl and vim.bo.modified then
      parts[#parts] = parts[#parts] .. M.modified_sign
      parts[#parts] = format_ll(self, parts[#parts], M.modified_hl)
    else
      parts[#parts] = format_ll(self, parts[#parts], M.filename_hl)
    end

    local dir = ""
    if #parts > 1 then
      dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
      dir = format_ll(self, dir .. sep, M.directory_hl)
    end
    return dir .. parts[#parts]
  end
}

M.root_hl = "#65BCFF"
M.root = {
  function(self)
    return vim.fs.basename(get_cwd())
  end,
  color = function(section)
	  return { fg = M.root_hl }
  end,
}

return M
