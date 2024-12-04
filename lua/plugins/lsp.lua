return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local function on_attach(client, buf)
        local map = function(mode, l, r, opts)
          opts = opts or {}
          opts.silent = true
          opts.buffer = buf
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
        map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
        map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous definition" })
        map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
        map("n", "K", vim.lsp.buf.hover, { desc = "Hover current variable" })
        map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help" })
        map("n", "<Space>r", vim.lsp.buf.rename, { desc = "Rename current variable" })
        map("n", "<Space>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
        map("n", "<Space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
        map("n", "<Space>wl", function()
          vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()), "info", {
            title = "LSP Workspace Folders",
            timeout = 2000,
          })
        end, { desc = "List workspace folders" })

        if client.server_capabilities.documentFormattingProvider then
          map("n", "<Space>f", vim.lsp.buf.format, { desc = "Format buffer" })
        end
      end

      lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- Use box borders for LSP floating windows
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single",
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "single",
      })

      lspconfig.lua_ls.setup({})
      lspconfig.csharp_ls.setup({
        on_attach = on_attach,
        handlers = {
          ["textDocument/definition"] = require('csharpls_extended').handler,
          ["textDocument/typeDefinition"] = require('csharpls_extended').handler,
        },
      })
      lspconfig.rust_analyzer.setup({
        -- capabilities = capabilities,
        on_attach = on_attach
      })

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "●",
            [vim.diagnostic.severity.WARN] = "●",
            [vim.diagnostic.severity.HINT] = "●",
            [vim.diagnostic.severity.INFO] = "●",
          },
        },
        underline = false,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = false,
        },
        severity_sort = true,
      })
    end,
  },
  -- C# Decompilation
  { "Decodetalkers/csharpls-extended-lsp.nvim", lazy = true }
}
