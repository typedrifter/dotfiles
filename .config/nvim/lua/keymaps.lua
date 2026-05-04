-- General

-- Open file explorer
-- vim.keymap.set("n", "<leader>fe", "<cmd>Explore<CR>", { desc = "Open file explorer" })

vim.keymap.set("n", "<leader>Y", [["+Y]])
-- vim.keymap.set("n", "<leader>N", "<cmd>silent !tmux split-window -v -l 20 zsh<CR>", { desc = "Open tmux terminal" })
vim.keymap.set(
	"n",
	"<leader>N",
	"<cmd>silent !tmux select-window -t terminal 2>/dev/null || tmux new-window -n terminal<CR>",
	{ desc = "Switch to or open tmux terminal" }
)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LSP", {}),
	callback = function(e)
		-- Most keymaps come from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

		-- Function that lets us more easily define mappings specific
		-- for LSP related items. It sets the mode, buffer and description for us each time.
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = e.buf, desc = "LSP: " .. desc })
		end

		local fzf_lua = require("fzf-lua")

		-- LSP mappings
		map("<leader>gd", fzf_lua.lsp_definitions, "[G]oto [D]efinition")
		map("<leader>gt", fzf_lua.lsp_typedefs, "[G]oto [T]ype Definition")
		map("<leader>gD", fzf_lua.lsp_declarations, "[G]oto [D]eclaration")
		map("<leader>gr", fzf_lua.lsp_references, "[G]oto [R]eferences")
		map("<leader>gi", fzf_lua.lsp_implementations, "[G]oto [I]mplementation")
		map("<leader>ds", fzf_lua.lsp_document_symbols, "[D]ocument [S]ymbols")
		map("<leader>ws", fzf_lua.lsp_workspace_symbols, "[W]orkspace [S]ymbols")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", fzf_lua.lsp_code_actions, "[C]ode [A]ctions", { "n", "x" })

		-- Diagnostics mappings
		map("<leader>fd", fzf_lua.diagnostics_workspace, "[F]ind [D]iagnostics")
		map("<leader>vd", vim.diagnostic.open_float, "[V]iew [D]iagnostics")

		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(e.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = e.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = e.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		-- The following code creates a keymap to toggle inlay hints in your
		-- code, if the language server you are using supports them
		--
		-- This may be unwanted, since they displace some of your code
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = e.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})
