vim.pack.add({
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
})

require("blink.cmp").setup({
	keymap = { preset = "default" },
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = false },
		menu = {
			draw = {
				padding = { 1, 0 },
				columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
				-- columns = { { "kind_icon", "kind" }, { "label", "label_description", gap = 1 } },
				components = {
					kind_icon = { width = { fill = true } },
					-- kind = {
					-- 	ellipsis = true,
					-- 	width = { fill = false },
					-- },
				},
			},
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = {
		implementation = "prefer_rust_with_warning",
	},
})
