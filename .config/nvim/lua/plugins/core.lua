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
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = false,
      },
    },
  },
  -- FIX: This shows it on the start page as well
  -- {
  --   "akinsho/bufferline.nvim",
  --   opts = {
  --     options = {
  --       always_show_bufferline = true,
  --     },
  --   },
  -- },
}
