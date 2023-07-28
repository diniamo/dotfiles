return {
    {
        "numToStr/FTerm.nvim",
        opts = { border = "rounded" },
        keys = {
            { "<C-t>", '<CMD>lua require("FTerm").toggle()<CR>', mode = 'n' },
            { "<C-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = 't' },
        }
    }
}
