return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true, -- this shows hidden files
          hide_dotfiles = false, -- this ensures dotfiles are not hidden
          hide_gitignored = false, -- this ensures gitignored files are not hidden
        },
      },
    })
    
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>")
    vim.keymap.set("n", "<C-k>", ":Neotree close<CR>")
  end,
}
