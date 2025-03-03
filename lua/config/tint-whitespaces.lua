-- Set up trailing whitespace highlighting
vim.api.nvim_create_augroup("HighlightTrailingWhitespace", { clear = true })

-- Define the highlight group
vim.cmd("highlight ExtraWhitespace ctermbg=red guibg=red")

-- Refresh highlight when colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  group = "HighlightTrailingWhitespace",
  pattern = "*",
  callback = function()
    vim.cmd("highlight ExtraWhitespace ctermbg=red guibg=red")
  end
})

-- Match trailing whitespace in all file types
vim.api.nvim_create_autocmd({"BufEnter", "WinEnter"}, {
  group = "HighlightTrailingWhitespace",
  pattern = "*",
  callback = function()
    vim.cmd([[match ExtraWhitespace /\s\+$/]])
  end
})
