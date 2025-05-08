return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Use extra capabilities from blink.cmp
      "saghen/blink.cmp"
    },
    config = function()
      -- Core LSP configuration
      --
      -- While this isn't necessary anymore after >= 11.0 because of vim.lsp.config, it's still useful
      -- for backwards compatability and providing sensible defaults for all servers.
      --
      -- The following function gets ran every time an LSP client attaches to a buffer. It will configure
      -- features like auto-show diagnostics on hover, initialize key-bindings and more.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          -- Small helper function which declares a key-map in normal mode
          local map = function(l, r, opts)
            opts = opts or {}
            opts.buffer = event.buf
            opts.silent = true
            vim.keymap.set("n", l, r, opts)
          end

          map("gd", vim.lsp.buf.definition, { desc = "Go to definition" })
          map("gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
          map("gr", vim.lsp.buf.references, { desc = "Show references" })
          map("]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
          map("[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
          map("<S-k>", vim.lsp.buf.hover, { desc = "Show hover documentation" })
          map("<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help" })
          map("<Space>r", vim.lsp.buf.rename, { desc = "Rename current variable" })

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- Bind formatting if this server provides one
          if client and client.server_capabilities.documentFormattingProvider then
            map("<Space>f", vim.lsp.buf.format, { desc = "Format buffer" })
          end
        end,
      })

      vim.api.nvim_set_hl(0, "DiagnosticLineError", { bg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextError" }).bg });
      vim.api.nvim_set_hl(0, "DiagnosticLineWarn", { bg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextWarn" }).bg });
      vim.api.nvim_set_hl(0, "DiagnosticLineInfo", { bg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextInfo" }).bg });
      vim.api.nvim_set_hl(0, "DiagnosticLineHint", { bg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextHint" }).bg });

      vim.diagnostic.config({
        severity_sort = true,
        underline = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
          linehl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
            [vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticLineInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticLineHint",
          },
          virtual_text = {
            spacing = 4,
            source = false,
          },
        },
        float = {
          border = "single",
          source = "if_many",
        },
      })

      -- Get LSP capabilties provided by blink.cmp
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local lspconfig = require("lspconfig")
      -- Language-specific config setups
      lspconfig.clangd.setup({ capabilities = capabilities })
      lspconfig.rust_analyzer.setup({ capabilities = capabilities })
      lspconfig.pylsp.setup({ capabilities = capabilities })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            }
          },
        }
      })
    end,
  },
}
