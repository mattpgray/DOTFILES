function ColorMyPencils(color)
	color = color or "dracula"
	vim.cmd.colorscheme(color)

	-- Uncomment the below if there is a nice background in the terminal already.
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

