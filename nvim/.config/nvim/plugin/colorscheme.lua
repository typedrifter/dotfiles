-- vim.pack.add({ "https://github.com/vague-theme/vague.nvim" })
-- vim.cmd.colorscheme("vague")
-- vim.pack.add({ "https://github.com/oxfist/night-owl.nvim" })
-- require("night-owl").setup()
-- vim.cmd.colorscheme("night-owl")
-- vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })
-- vim.cmd.colorscheme("catppuccin-nvim")
-- vim.pack.add({ { src = "https://github.com/EdenEast/nightfox.nvim" } })
-- vim.cmd.colorscheme("duskfox")
-- vim.pack.add({ { src = "https://github.com/kepano/flexoki-neovim", name = "flexoki" } })
-- vim.cmd("colorscheme flexoki-dark")
-- vim.pack.add({ "https://github.com/olimorris/onedarkpro.nvim" })
-- vim.cmd("colorscheme onedark")
-- vim.pack.add({
-- 	"https://github.com/navarasu/onedark.nvim",
-- })
-- require("onedark").setup({
-- 	style = "darker",
-- })
-- require("onedark").load()
vim.pack.add({ "https://github.com/rebelot/kanagawa.nvim" })
vim.pack.add({ "https://github.com/samharju/synthweave.nvim" })
vim.pack.add({ "https://github.com/shaunsingh/moonlight.nvim" })
vim.pack.add({ "https://github.com/neanias/everforest-nvim" })
vim.pack.add({ "https://github.com/AlexvZyl/nordic.nvim" })
vim.pack.add({ "https://github.com/EdenEast/nightfox.nvim" })
vim.pack.add({ "scottmckendry/cyberdream.nvim" })
vim.pack.add({ "https://github.com/catppuccin/nvim" })
vim.pack.add({ "https://github.com/olimorris/onedarkpro.nvim" })
vim.pack.add({ "https://github.com/cpea2506/one_monokai.nvim" })
-- vim.cmd("colorscheme tokyonight")

require("one_monokai").setup({
	transparent = true,
	colors = {},
	highlights = function(colors)
		return {}
	end,
	italics = true,
	cache = {
		path = vim.fs.joinpath(vim.fn.stdpath("cache"), "one_monokai"),
	},
})
