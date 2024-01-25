return {
    {
        {
            "epwalsh/obsidian.nvim",
            ft = "markdown",
            opts = {
                workspaces = {
                    {
                        name = "Notes",
                        path = "~/Documents/Notes",
                    },
                },
                attachments = {
                    img_folder = "Attachments",
                },
                disable_frontmatter = true
            },
            init = function()
                vim.opt.linebreak = true
            end
        },
    },
}
