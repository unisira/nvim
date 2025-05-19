return {
  -- 'Batteries included' auto-completion
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
      -- Disable during dressing input fields (re-naming)
      enabled = function()
        return not vim.list_contains({ 'DressingInput' }, vim.bo.filetype)
          and vim.bo.buftype ~= 'prompt'
          and vim.b.completion ~= false
      end,
      keymap = { preset = "enter", },
      appearance = {
        nerd_font_variant = 'mono'
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          border = "none",
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "none",
          },
        },
      },
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer"
        },
        providers = {
          lsp = {
            -- By default this filters out text items which causes macros to be filtered out incorrectly
            transform_items = function(_, items)
              return items
            end
          },
        },
      },
    },
  },
}
