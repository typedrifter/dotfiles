vim.pack.add({ "https://github.com/nickjvandyke/opencode.nvim" })

vim.keymap.set({ "n", "t" }, "<C-.>", function()
	require("opencode").toggle()
end, { desc = "Toggle opencode" })
