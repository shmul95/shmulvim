-- lua/pluggins/telescope
return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			defaults = {
				prompt_prefix = "🔍 ",
				file_ignore_patterns = { "node_modules", ".git/" },
				-- …
			},
			pickers = {
				find_files = {
					theme = "dropdown",
				},
			},
			extensions = {
				fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true },
			},
		})
		-- load fzf-native if installed:
		pcall(require("telescope").load_extension, "fzf")
	end,
}
