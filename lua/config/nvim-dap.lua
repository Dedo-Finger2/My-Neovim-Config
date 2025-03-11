local dap, dapui = require("dap"), require("dapui")

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" }
}

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = 9229,
	executable = {
		command = "node",
		args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "9229" },
	},
}

dap.configurations.javascript = {
	{
		name = "Launch file",
		type = "pwa-node",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		name = "Attach to process",
		type = "pwa-node",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}

dap.configurations.typescript = {
	{
		name = "Launch TS file (Node)",
		type = "pwa-node",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
		runtimeArgs = { "--experimental-strip-types" },
	},
	{
		name = "Attach to process (TS)",
		type = "pwa-node",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}

dap.configurations.typescript = dap.configurations.typescript
dap.configurations.javascript = dap.configurations.javascript

require("dapui").setup()

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
