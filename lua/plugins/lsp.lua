return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- vim.lsp.log.set_level(vim.log.levels.OFF)

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

        -- Show diagnostics on hold
        -- vim.api.nvim_create_autocmd("CursorHold", {
        --   buffer = buf,
        --   callback = function()
        --     local opts = {
        --       focusable = false,
        --       close_events = {
        --         "BufLeave",
        --         "CursorMoved",
        --         "InsertEnter",
        --       },
        --       source = false,
        --       scope = "line",
        --       border = "single",
        --     }
        --     vim.diagnostic.open_float(0, opts)
        --   end,
        -- })
        -- Highlight variable under cursor
        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "Visual" })
          vim.api.nvim_set_hl(0, "LspReferenceText", { link = "Visual" })
          vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "Visual" })

          -- FIXME: Doesn't work, also move into util/lsp.lua
          --
          -- local hlgroup = vim.api.nvim_create_augroup("lsp_document_highlight")
          -- vim.api.nvim_create_autocmd("CursorHold" , {
          --   group = hlgroup,
          --   buffer = buf,
          --   callback = function()
          --     vim.notify("CursorHold hit")
          --     vim.lsp.buf.document_highlight()
          --   end
          -- })
          -- vim.api.nvim_create_autocmd("CursorMoved", {
          --   group = hlgroup,
          --   buffer = buf,
          --   callback = vim.lsp.buf.clear_references
          -- })
        end
      end

      lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "c", "cpp", "cc" },
        flags = {
          debounce_text_changes = 500,
        },
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
        -- capabilities = capabilities,
        on_attach = on_attach
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
}
