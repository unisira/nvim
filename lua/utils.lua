local M = {}

function M.executable(name)
  if vim.fn.executable(name) > 0 then
    return true
  end

  return false
end

--- Run a callback whenever a plugin is lazy-loaded
-- function M.on_lazy_load(name, callback)
--   vim.api.nvim_create_autocmd("User", {
--     pattern = "LazyLoad",
--     callback = function(event)
--       if event.data == name then
--         callback()
--         return true
--       end
--     end,
--   })
-- end

return M
