-- LSP keymaps and behavior on attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local map = function(l, r, opts)
      opts = opts or {}
      opts.buffer = event.buf
      opts.silent = true
      vim.keymap.set("n", l, r, opts)
    end

    map("gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    map("gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    map("gr", vim.lsp.buf.references, { desc = "Show references" })
    map("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
    map("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous diagnostic" })
    map("<S-k>", vim.lsp.buf.hover, { desc = "Show hover documentation" })
    map("<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help" })
    map("<Space>r", vim.lsp.buf.rename, { desc = "Rename current variable" })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/formatting') then
      map("<Space>f", vim.lsp.buf.format, { desc = "Format buffer" })
    end
  end,
})

-- Diagnostics
vim.diagnostic.config({
  severity_sort = true,
  underline = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
      [vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticLineInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticLineHint",
    },
  },
  virtual_text = {
    spacing = 4,
    source = false,
  },
  float = {
    border = "single",
    source = true,
  },
})

-- Inject blink.cmp capabilities into all servers once the plugin is loaded
vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpReady",
  once = true,
  callback = function()
    vim.lsp.config('*', {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })
  end,
})

-- Server configurations (native vim.lsp.config)
vim.lsp.config('clangd', {
  cmd = { 'clangd' },
  root_markers = { '.clangd', 'compile_commands.json', 'compile_flags.txt', '.git' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
})

vim.lsp.config('pylsp', {
  cmd = { 'pylsp' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
  filetypes = { 'python' },
})

vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  root_markers = { 'Cargo.toml', '.git' },
  filetypes = { 'rust' },
})

vim.lsp.enable({ 'clangd', 'pylsp', 'rust_analyzer' })
