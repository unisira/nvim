local M = {}

M.style = function(config)
  for filetype, opts in pairs(config) do
    -- Use default options if none were set
    opts = vim.tbl_extend("force", {
      space = vim.opt.expandtab,
      width = vim.opt.shiftwidth,
    }, opts or {})
    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetype,
      callback = function(event)
        vim.bo[event.buf].expandtab = opts.spaces
        vim.bo[event.buf].shiftwidth = opts.width
        vim.bo[event.buf].tabstop = opts.width
        if opts.comment then
          vim.bo[event.buf].commentstring = opts.comment
        end
      end,
    })
  end
end

return M
