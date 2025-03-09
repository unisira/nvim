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
        vim.api.nvim_buf_set_option(event.buf, "expandtab", opts.spaces)
        vim.api.nvim_buf_set_option(event.buf, "shiftwidth", opts.width)
        vim.api.nvim_buf_set_option(event.buf, "tabstop", opts.width)
        if opts.comment then
          vim.api.nvim_buf_set_option(event.buf, "commentstring", opts.comment)
        end
      end,
    })
  end
end

return M
