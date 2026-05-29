vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
})

local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
local diagnostic_signs = {}
for type, icon in pairs(signs) do
	diagnostic_signs[vim.diagnostic.severity[type]] = icon
end
vim.diagnostic.config({ signs = { text = diagnostic_signs } })

vim.lsp.enable("tsgo")
vim.lsp.enable("oxlint")
vim.lsp.enable("oxfmt")
vim.lsp.enable("gopls")
vim.lsp.enable("bashls")
