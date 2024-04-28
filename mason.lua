return {
  {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    -- event = "VeryLazy",
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local servers = {
        clangd = {},
      }

      require("mason").setup()
      require("mason-tool-installer").setup({
        ensure_installed = { "clangd" },
      })
      require("mason-lspconfig").setup({
        handlers = {
          function(server)
            require("lspconfig")[server].setup(capabilities)
          end,
        }
      })
    end,
  }
}
