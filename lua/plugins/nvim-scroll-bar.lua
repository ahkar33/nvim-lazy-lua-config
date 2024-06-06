return {
	"petertriho/nvim-scrollbar",
	config = function()
		require("scrollbar").setup({
			marks = {
				Search = { color = "#FFA07A" }, -- Salmon
				Error = { color = "#FF6347" }, -- Tomato
				Warn = { color = "#FFD700" }, -- Gold
				Info = { color = "#87CEEB" }, -- SkyBlue
				Hint = { color = "#ADFF2F" }, -- GreenYellow
				Misc = { color = "#BA55D3" }, -- MediumOrchid
			},
		})
	end,
}
