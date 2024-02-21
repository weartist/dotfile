return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
    -- event = "VeryLazy",
    build = ":TSUpdate",
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { 'help' }, -- list of language that will be disabled
    }
}

