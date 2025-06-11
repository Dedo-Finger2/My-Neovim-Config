-- Aqui eu configuro o Shift + L para mostrar o hover de
-- diagnostico do LSP. Se um erro estiver sendo mostrado
-- posso apertar Shift + L para ver detalhes desse erro/aviso.

vim.keymap.set("n", "L", vim.diagnostic.open_float)
