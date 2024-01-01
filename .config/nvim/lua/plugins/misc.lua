return {
  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = "<C-t>",
      shade_terminals = false,
      direction = "float",
      -- Use background colored single border for padding
      float_opts = {
        border = "single",
      },
      highlights = {
        NormalFloat = {
          guibg = "#24273a",
        },
        FloatBorder = {
          guifg = "#24273a",
          guibg = "#24273a",
        },
      },
    },
    keys = {
      { "<C-t>" },
      { "<leader>gg" },
      { "<leader>gG" },
    },
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
}
