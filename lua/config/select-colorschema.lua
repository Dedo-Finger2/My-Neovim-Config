-- Isso é uma função que uso para selecionar o tema de cores.

return function(name)
	vim.cmd("colorscheme " .. name)
end
