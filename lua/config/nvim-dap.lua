local dap, dapui = require("dap"), require("dapui")

local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

local function pick_node_process()
  local handle = io.popen("ps aux | grep node | grep -v grep")
  if not handle then return nil end
  local result = handle:read("*a")
  handle:close()

  local processes = {}
  for line in result:gmatch("[^\r\n]+") do
    local pid = line:match("^%S+%s+(%d+)")
    local cmd = line:match("%d+%s+(.*)$")
    if pid and cmd then
      table.insert(processes, {
        pid = pid,
        name = cmd
      })
    end
  end

  vim.ui.select(processes, {
    prompt = "Select Node process:",
    format_item = function(item)
      return string.format("PID %s: %s", item.pid, item.name)
    end
  }, function(choice)
    return choice and tonumber(choice.pid) or nil
  end)
end

require("dapui").setup()

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",  -- Match the IP from your debugger message
  port = "${port}",
  executable = {
    command = "node",
    args = {
      vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/dist/vsDebugServer.js",
      "${port}"
    }
  }
}

for _, language in ipairs(js_based_languages) do
	dap.configurations[language] = {
		-- Debug single nodejs files
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
		},
    {
    name = "Attach to Node",
    type = "pwa-node",
    request = "attach",
		processId = pick_node_process,
    protocol = "inspector",
    port = 9229,  -- Direct port specification
    timeout = 3000,
    sourceMaps = true,
    localRoot = "${workspaceFolder}",
    remoteRoot = nil,
    resolveSourceMapLocations = {
      "${workspaceFolder}/**",
      "!**/node_modules/**"
    },
    attachExistingChildren = false,
    autoAttachChildProcesses = false
  },		-- Debug nodejs processes (make sure to add --inspect when you run the process)
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
		},
		-- Debug web applications (client side)
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch & Debug Chrome",
			url = function()
				local co = coroutine.running()
				return coroutine.create(function()
					vim.ui.input({
						prompt = "Enter URL: ",
						default = "http://localhost:3000",
					}, function(url)
						if url == nil or url == "" then
							return
						else
							coroutine.resume(co, url)
						end
					end)
				end)
			end,
			webRoot = vim.fn.getcwd(),
			protocol = "inspector",
			sourceMaps = true,
			userDataDir = false,
		},
		-- Divider for the launch.json derived configs
		{
			name = "----- ↓ launch.json configs ↓ -----",
			type = "",
			request = "launch",
		},
	}
end

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

vim.keymap.set("n", "<Leader>dt", ":DapUiToggle<CR>", {})
vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {})
vim.keymap.set("n", "<Leader>dc", dap.continue, {})
vim.keymap.set("n", "<Leader>dn", dap.step_over, {})
vim.keymap.set("n", "<Leader>di", dap.step_into, {})
vim.keymap.set("n", "<Leader>do", dap.step_out, {})
vim.keymap.set("n", "<Leader>dr", ":lua require('dapui').open({reset = true})<CR>", {})

vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "⏺", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)

