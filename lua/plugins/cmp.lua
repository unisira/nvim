return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      -- "hrsh7th/cmp-nvim-lsp-signature-help",
      -- "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- TODO: Fix this, it STILL jumps to expired sessions on tab
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Esc>"] = cmp.mapping.close(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-n>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- For nvim-lsp
          { name = "nvim_lsp_signature_help" }, -- For signature help
          { name = "nvim_lsp_document_symbol" }, -- For quick document-wide symbol search (/@ <sym>)
          { name = "luasnip" }, -- for snippets
          { name = "path" }, -- for path completion
        }),
        formatting = {
          truncate = {
            enable = true,
            char = "…",
            fields = {
              "abbr",
              "menu",
            },
            width = 30,
          },
          -- Display order of entry fields
          fields = {
            "abbr",
            "kind",
            "menu",
          },
          format = function(_, item)
            local opts = require("cmp.config").get().formatting.truncate
            -- Return item as-is if truncation is disabled
            if not opts.enable then
              return item
            end

            -- Truncate `contents` to `length`
            local function truncate(contents, length)
              if not contents then
                return
              end

              if #contents > length + 1 then
                contents = vim.fn.strcharpart(contents, 0, length) .. opts.char
              end

              return contents
            end

            for _, field in ipairs(opts.fields) do
              if item[field] then
                item[field] = truncate(item[field], opts.width)
              end
            end

            return item
          end
        }
      })

      cmp.setup.cmdline({ '/', '?', ':' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
          { name = 'path' },
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            },
          },
        },
      })
    end,
  },
}
