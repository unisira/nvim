local M = {}

-- NOTE: This function will become useless after 0.10 releases, but it
-- was still fun to write, I want to write so many things with the LSP now
--
-- It is a shame no one knows how to write a decent plugin
function M.hover(_, result, ctx, config)
  -- vim.notify(vim.inspect(result))
  -- vim.notify(vim.inspect(config))
  -- vim.notify(vim.inspect(ctx))
  return vim.lsp.handlers.hover(_, result, ctx, config)
end

-- Backup of original `vim.lsp.util.open_floating_preview` function
-- M.builtin_open_floating_preview = vim.lsp.util.open_floating_preview
--
-- vim.lsp.util.open_floating_preview = function(contents, syntax, config)
--   return M.builtin_open_floating_preview(contents, syntax, config)
-- end

-- Backup of original `vim.lsp.util.preview_location` function
-- M.builtin_preview_location = vim.lsp.util.preview_location
--
-- vim.lsp.util.preview_location = function(location, opts)
--   vim.notify(vim.inspect(contents) .. "\n" .. vim.inspect(syntax) .. "\n" .. vim.inspect(config))
--   return M.builtin_preview_location(location, opts)
-- end

return M
