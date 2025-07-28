local M = {
  "mfussenegger/nvim-dap",
}

function M.config()
  local dap = require("dap")

  -- GDB Adapter (you can also use lldb or codelldb)
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
  }

  dap.configurations.cpp = {
    {
      name = "Launch C++ file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = true,
      args = {},
      runInTerminal = false,
    },
  }

  -- Optional: Apply same config to C
  dap.configurations.c = dap.configurations.cpp

  -- Keymaps
  vim.keymap.set("n", "<F5>", function() dap.continue() end)
  vim.keymap.set("n", "<F10>", function() dap.step_over() end)
  vim.keymap.set("n", "<F11>", function() dap.step_into() end)
  vim.keymap.set("n", "<F12>", function() dap.step_out() end)
  --vim.keymap.set("n", "<Leader>b", function() dap.toggle_breakpoint() end)
end
return M
