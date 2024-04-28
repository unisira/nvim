local lsp = require("util.lsp")

return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      vim.lsp.set_log_level("off")

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- I think mason does this automatically? I'm not sure, I don't care
      lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = function(client, buf)
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
          map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
          map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
          map("n", "<space>rn", vim.lsp.buf.rename, { desc = "Rename variable" })
          map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
          map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
          map("n", "<space>wl", function()
            vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()), "info", {
              title = "LSP Workspace Folders",
              timeout = 2000,
            })
          end, { desc = "list workspace folder" })

          if client.server_capabilities.documentFormattingProvider then
            map("n", "<space>f", vim.lsp.buf.format, { desc = "format code" })
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
        end,
        filetypes = { "c", "cpp", "cc" },
        flags = {
          debounce_text_changes = 500,
        },
      })

      lspconfig.lua_ls.setup({})
      lspconfig.rust_analyzer.setup({
        -- capabilities = capabilities,
      })

      vim.diagnostic.config({
        underline = false,
        update_in_insert = false,
        -- virtual_text = false,
        virtual_text = {
          spacing = 4,
          source = false,
          -- prefix = "!",
        },
        severity_sort = true,
      })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single",
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "single",
      })
    end,
  },
  -- {
  --   "williamboman/mason.nvim",
  --   cmd = "Mason",
  --   keys = {
  --     { "<leader>cm", "<Cmd>Mason<CR>", desc = "Open Mason" },
  --   },
  --   opts = {
  --     ensure_installed = {
  --     }
  --   },
  -- },
}
