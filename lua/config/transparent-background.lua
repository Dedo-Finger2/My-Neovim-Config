vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
		vim.api.nvim_set_hl(0, "TabLineSelect", { bg = "none" })
		vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
		vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
		vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
		vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
		vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
		vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none", fg = "none" })
		vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none", fg = "none" })
		vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "none", fg = "none" })
		vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "none", fg = "none" })
	end
})
