-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Make line numbers default
vim.opt.number = true

-- Show relative line numbers
vim.opt.relativenumber = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Configure tab-related behavior
vim.opt.tabstop = 2 -- Number of spaces that a tab character represents
vim.opt.softtabstop = 2 -- Number of spaces used when hitting <Tab> in insert mode
vim.opt.shiftwidth = 2 -- Number of spaces used for indentation
vim.opt.expandtab = true -- Convert tabs to spaces

-- Enable smart indentation based on the file type
vim.opt.smartindent = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Customize netrw
-- Disable the Netrw banner for a cleaner view.
vim.g.netrw_banner = 0

-- Use a single-column file listing style.
vim.g.netrw_liststyle = 3

-- Configure buffer: no line numbers, read-only, not listed.
vim.g.netrw_bufsettings = "nonu nornu noma ro nobl"

-- Open files in the same window (set to 4 to open in another window).
vim.g.netrw_browse_split = 0
-- Replace default directory separators with Unicode symbols for better aesthetics.
vim.g.netrw_dirgrphics = "├│─ "

vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		-- Replace directory marker '=' with a folder icon.
		vim.cmd([[syntax match NetrwDirectory "\s\+=\s"]])
		-- Replace file marker '*' with a file icon.
		vim.cmd([[syntax match NetrwFile "\s\+\*"]])
	end,
})

-- Fix issues with bun hot reloading https://github.com/oven-sh/bun/issues/8520
vim.opt.backupcopy = "yes"

-- Remove bottom unused line
vim.o.cmdheight = 0

--
-- vim.api.nvim_create_autocmd("BufRead", {
-- 	pattern = "*.py", -- Trigger only for Python files
-- 	callback = function()
-- 		-- Skip if already loaded
-- 		if vim.env.VIRTUAL_ENV then
-- 			return
-- 		end
--
-- 		local cwd = vim.fn.getcwd() -- Get current working directory
-- 		local venv_path = cwd .. "/.venv"
--
-- 		-- Check if .venv exists and activate it
-- 		if vim.fn.isdirectory(venv_path) == 1 then
-- 			-- Activate the virtual environment by setting the PATH
-- 			vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH
-- 			vim.env.VIRTUAL_ENV = venv_path
-- 			-- Set the Python interpreter for Neovim
-- 			vim.g.python3_host_prog = venv_path .. "/bin/python"
-- 			vim.notify("Virtual environment loaded from: " .. venv_path)
-- 		else
-- 			vim.notify("No virtual environment found")
-- 		end
-- 	end,
-- })

-- vim.diagnostic.config({
-- 	severity_sort = true,
-- 	float = { border = "rounded", source = "if_many" },
-- 	underline = { severity = vim.diagnostic.severity.ERROR },
-- 	signs = vim.g.have_nerd_font and {
-- 		text = {
-- 			[vim.diagnostic.severity.ERROR] = "󰅚 ",
-- 			[vim.diagnostic.severity.WARN] = "󰀪 ",
-- 			[vim.diagnostic.severity.INFO] = "󰋽 ",
-- 			[vim.diagnostic.severity.HINT] = "󰌶 ",
-- 		},
-- 	} or {},
-- 	virtual_text = {
-- 		source = "if_many",
-- 		spacing = 2,
-- 		format = function(diagnostic)
-- 			local diagnostic_message = {
-- 				[vim.diagnostic.severity.ERROR] = diagnostic.message,
-- 				[vim.diagnostic.severity.WARN] = diagnostic.message,
-- 				[vim.diagnostic.severity.INFO] = diagnostic.message,
-- 				[vim.diagnostic.severity.HINT] = diagnostic.message,
-- 			}
-- 			return diagnostic_message[diagnostic.severity]
-- 		end,
-- 	},
-- })
--
vim.diagnostic.config({
	virtual_text = {
		-- source = "always",  -- Or "if_many"
		prefix = "●", -- Could be '■', '▎', 'x'
	},
	severity_sort = true,
	float = {
		source = true, -- Or "if_many"
	},
})
