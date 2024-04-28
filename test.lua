local function lnotify(contents)
  contents = vim.inspect(contents)
  vim.notify(contents, "error", {
    title = "LSP",
    timeout = 1000
  })
end

opts = {
  wrap = false,
  border = "single",
  style = "minimal",
  width = 50,
}

local function custom_def_cb(_, method, result)
  if not method or not result then
  	return
  end

  local request = method[1] or method
  local uri = request.uri or request.targetUri
  local range = request.range or request.targetRange

  -- TODO: Multi-line definitions for long functions or similar, store the original range
  -- then change this for the 'view' range, and highlight each line
  -- TODO: Highlight everything on the line, not just characters
  range["start"].line = range["start"].line - 3
  range["end"].line = range["end"].line + 5

  bufnr, winnr = vim.lsp.util.preview_location({
    uri = uri,
    range = range,
  }, opts)

  vim.api.nvim_buf_add_highlight(bufnr, -1, "CursorLine", 3, 0, -1)
end

local function preview_definition(opts)
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, "textDocument/definition", params, custom_def_cb)
end

local my_var = "this is a string"

-- lnotify(my_var)

my_var = my_var .. "hi_there"

preview_definition()

local function custom_hover(opts)
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, "textDocument/hover", params, custom_def_cb)
end


