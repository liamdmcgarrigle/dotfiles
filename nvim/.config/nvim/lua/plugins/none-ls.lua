return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {

				-- lua
				null_ls.builtins.formatting.stylua,

				-- js / ts
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.diagnostics.eslint_d,

				-- yaml
				null_ls.builtins.formatting.yamlfmt,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
