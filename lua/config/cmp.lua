local cmp = require('cmp')

cmp.setup({
	sorting = {
		comparators = {
			-- Keep default comparators but add our custom logic first
			function(entry1, entry2)
				local is_snippet1 = entry1:get_kind() == 15 -- 15 = LSP's CompletionItemKind.Snippet
				local is_snippet2 = entry2:get_kind() == 15

				-- Prioritize non-snippets over snippets
				if is_snippet1 ~= is_snippet2 then
					return not is_snippet1 -- Non-snippets come first
				end
			end,

			-- Fall back to default comparators
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.locality,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		}
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
	mapping = cmp.mapping.preset.insert({
		['<Tab>'] = cmp.mapping(function(fallback)
			local col = vim.fn.col('.') - 1

			if cmp.visible() then
				cmp.select_next_item({ behavior = 'select' })
			elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
				fallback()
			else
				cmp.complete()
			end
		end, { 'i', 's' }),

		-- Go to previous item
		['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm({ select = false }),
	}),
})
