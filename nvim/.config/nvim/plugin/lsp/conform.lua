vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd", "prettier", lsp_format = "first" },
		json = { "prettierd", "prettier", lsp_format = "first" },
		typescript = { lsp_format = "prefer" },
		astro = { "prettierd", "prettier", lsp_format = "first" },
		typescriptreact = { "oxfmt", lsp_format = "first" },
		markdown = { "markdownlint-cli2", lsp_format = "first" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
