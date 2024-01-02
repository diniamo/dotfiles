return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "jvgrootveld/telescope-zoxide",
        },
        init = function()
            local telescope = require("telescope")

            telescope.load_extension("zoxide")
            vim.keymap.set("n", "<leader>z", telescope.extensions.zoxide.list)
        end,
        keys = {
            { "<leader>z" },
        },
    },
}
