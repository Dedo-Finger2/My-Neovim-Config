-- Leader on space
vim.g.mapleader = " "

-- Open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move between buffers
vim.keymap.set("n", "<C-j>", '<C-w><C-j>')
vim.keymap.set("n", "<C-k>", '<C-w><C-k>')
vim.keymap.set("n", "<C-l>", '<C-w><C-l>')
vim.keymap.set("n", "<C-h>", '<C-w><C-h>')
