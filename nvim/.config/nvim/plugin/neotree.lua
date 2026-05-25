-- Neo-tree is a Neovim plugin to browse the file system

vim.pack.add({
	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
	},
	-- dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	-- optional, but recommended
	"https://github.com/nvim-tree/nvim-web-devicons",
})

vim.keymap.set("n", "\\", "<cmd>Neotree toggle position=left reveal=true<CR>", { desc = "Toggle file explorer" }) -- toggle file explor

require("neo-tree").setup({
	close_if_last_window = true,
	buffers = {
		follow_current_file = true,
	},
	filesystem = {
		filtered_items = {
			visible = true, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = true,
			hide_gitignored = true,
			hide_hidden = true,
		},
		use_libuv_file_watcher = true,
		hijack_netrw_behavior = "open_current",
		follow_current_file = {
			enabled = true, -- This will find and focus the file in the active buffer every time
			--               -- the current file is changed while the tree is open.
			leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
		},
	},
})
