return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("catppuccin").load("macchiato")
      end,

      news = {
        neovim = true,
      },
    },
  },

  -- This shows it on the start page as well unfortunately
  -- {
  --   "akinsho/bufferline.nvim",
  --   opts = {
  --     options = {
  --       always_show_bufferline = true,
  --     },
  --   },
  -- },
}
