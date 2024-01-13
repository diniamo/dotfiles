return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "jvgrootveld/telescope-zoxide",
        },
        init = function()
            local telescope = require("telescope")
            local map = vim.keymap.set

            telescope.load_extension("zoxide")
            map("n", "<leader>zi", telescope.extensions.zoxide.list)
            map("n", "<leader>zz", function()
                local keyword = vim.fn.input("Keyword: ")
                local directory = vim.system({ "zoxide", "query", keyword }, { text = true })
                    :wait().stdout
                    :match("(.*)[\n\r]")

                if directory == "" or directory == nil then
                    vim.notify("No match found", vim.log.levels.ERROR)
                else
                    vim.notify(directory)
                    vim.fn.chdir(directory)
                end
            end)
        end,
        keys = {
            { "<leader>z" },
        },
    },
}
