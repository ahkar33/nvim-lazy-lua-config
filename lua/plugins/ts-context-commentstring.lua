return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring", -- Context-aware commenting
    event = "BufReadPost",
  },
  {
    "numToStr/Comment.nvim", -- Commenting plugin
    event = "BufReadPost",
    config = function()
      require("Comment").setup({
        pre_hook = function(ctx)
          -- Use ts-context-commentstring for filetypes with Treesitter integration
          local U = require("Comment.utils")
          local ts_commentstring = require("ts_context_commentstring.internal")
          local location = nil

          if ctx.ctype == U.ctype.block then
            location = ts_commentstring.calculate_commentstring({
              key = ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V and "multiline" or "singleline",
            })
          else
            location = ts_commentstring.calculate_commentstring({
              key = ctx.ctype == U.ctype.line and "singleline" or "multiline",
            })
          end

          return location
        end,
      })
    end,
  },
}

