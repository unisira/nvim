return {
  {
    "mfussenegger/nvim-dap",
    enabled = false,
    config = function()
      local dap = require("dap")
      -- Setup CodeLLDB server to start automatically
      dap.adapters.codelldb = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = {
            "--port", "${port}"
          },
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
}

