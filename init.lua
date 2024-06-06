local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-option")
require("lazy").setup("plugins")

-- Encapsulate key mappings in a local scope
local function setup_key_mappings()
	-- Map Ctrl + s to save in normal mode
	vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
	-- Map Ctrl + s to save in insert mode
	vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true })

	vim.api.nvim_set_keymap("n", "<ScrollWheelLeft>", "zh", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<ScrollWheelRight>", "zl", { noremap = true, silent = true })
end

-- Call the function to set up key mappings
setup_key_mappings()

-- Enable mouse support
vim.opt.mouse = "a"

-- Adjust horizontal scrolling settings
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 5









