vim.api.nvim_create_user_command("GoGenerateAllTests", function()
	local file = vim.fn.expand("%")
	vim.cmd("!gotests -w -all " .. file)
end, {})

vim.api.nvim_create_user_command("GoGenerateTest", function()
	local func = vim.fn.input("Func name: ")
	local file = vim.fn.expand("%")
	if func ~= "" then
		vim.cmd("!gotests -w -only " .. func .. " " .. file)
	else
		print("Invalid function name.")
	end
end, {})

vim.keymap.set("n", "<leader>gat", ":GoGenerateAllTests<CR>", { desc = "Generate tests for go files" })
vim.keymap.set("n", "<leader>ggt", ":GoGenerateTest<CR>", { desc = "Generate tests for go files" })
