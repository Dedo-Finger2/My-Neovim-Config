vim.opt.spelllang = { "en_us", "pt", "pt_br" }
vim.opt.spell = true

vim.keymap.set("n", "<leader>sr", vim.cmd.spellr) -- ???
vim.keymap.set("n", "<leader>ss", "z=")           -- Suggestions
vim.keymap.set("n", "<leader>sa", "zg")           -- Adds word to spelling
