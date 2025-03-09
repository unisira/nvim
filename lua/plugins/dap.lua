return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("dapui").setup()

      local dap = require("dap")
      -- Setup CodeLLDB server to start automatically
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = {
            "--port", "${port}"
          },
          detached = false,
        },
      }

      local tasks = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
        },
      }

      -- Initialize launch configurations for C/C++
      dap.configurations.c = tasks
      dap.configurations.cpp = tasks
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    keys = {
      { "<Space>dd", function() require("dapui").toggle() end, desc = "Toggle DapUI" },
      { "<Space>dl", "<Cmd>DapNew Launch<CR>", desc = "DAP - Launch" },
      { "<Space>db", "<Cmd>DapToggleBreakpoint<CR>", desc = "DAP - Toggle Breakpoint" },
      { "<Space>dc", "<Cmd>DapContinue<CR>", desc = "DAP - Continue" },
      { "<Space>ds", "<Cmd>DapStepOver<CR>", desc = "DAP - Step Over" },
      { "<Space>dS", "<Cmd>DapStepInto<CR>", desc = "DAP - Step Into" },
    }
  }
}

