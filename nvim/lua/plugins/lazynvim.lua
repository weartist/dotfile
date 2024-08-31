-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
-- 1. 准备lazy.nvim模块（存在性检测）
-- stdpath("data")
-- macOS/Linux: ~/.local/share/nvim
-- Windows: ~/AppData/Local/nvim-data

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end ---@diagnostic disable-next-line: undefined-field

-- 2. 将 lazypath 设置为运行时路径
-- rtp（runtime path）
-- nvim进行路径搜索的时候，除已有的路径，还会从prepend的路径中查找
-- 否则，下面 require("lazy") 是找不到的
vim.opt.rtp:prepend(lazypath)


local which_key = require('plugins.which_key')
local telescope = require('plugins.telescope')
local lsp_config = require('plugins.lsp_config')
local auto_format = require('plugins.auto_format')
local tree_sitter = require('plugins.nvim-treesitter')
local cmp = require('plugins.cmp')
-- local neo_tree = require('plugins.neo_tree')
local lint = require('plugins.lint')
local autopairs = require('plugins.autopairs')
local indent = require('plugins.indent')
local git_sign = require('plugins.git_sign')
local nvim_tree = require('plugins.nvim-tree')

local comment = {
    'numToStr/Comment.nvim',
    opts = {
        toggler = {
            ---Line-comment toggle keymap
            line = 'gcc',
            ---Block-comment toggle keymap
            block = 'gbc',
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
            ---Line-comment keymap
            line = 'gc',
            ---Block-comment keymap
            block = 'gb',
        },
        ---LHS of extra mappings
        extra = {
            ---Add comment on the line above
            above = 'gcO',
            ---Add comment on the line below
            below = 'gco',
            ---Add comment at the end of line
            eol = 'gcA',
        },
        ---Enable keybindings
        ---NOTE: If given `false` then the plugin won't create any mappings
        mappings = {
            ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
            basic = true,
            ---Extra mapping; `gco`, `gcO`, `gcA`
            extra = true,
        },
        ---Function to call before (un)comment
        pre_hook = nil,
        ---Function to call after (un)comment
        post_hook = nil,
    },
    lazy = false,
    config = function()
        require("Comment").setup()
    end
}

-- local git_sign = { -- Adds git related signs to the gutter, as well as utilities for managing changes
--     'lewis6991/gitsigns.nvim',
--     opts = {
--         signs = {
--             add = { text = '+' },
--             change = { text = '~' },
--             delete = { text = '_' },
--             topdelete = { text = '‾' },
--             changedelete = { text = '~' },
--         },
--     }
-- }

local highlight_todo = {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
}

local theme_gruvbox = {
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            -- Optionally configure and load the colorscheme
            -- directly inside the plugin declaration.
            vim.g.gruvbox_material_enable_italic = true
            vim.cmd.colorscheme('gruvbox-material')
        end
    }
}

local theme_kanagawa = {
    {
        'rebelot/kanagawa.nvim',
        lazy = false
    }
}

local plugins = {
    which_key,
    telescope,
    lsp_config,
    auto_format,
    tree_sitter,
    -- theme_gruvbox,
    theme_kanagawa,
    cmp,
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    -- "gc" to comment visual regions/lines
    comment,
    git_sign,
    highlight_todo,
    nvim_tree,
    lint,
    autopairs,
    indent

}

local opts = {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
}


require("lazy").setup(plugins, opts)
vim.cmd("colorscheme kanagawa")
