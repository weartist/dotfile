-- 1. 准备lazy.nvim模块（存在性检测）
-- stdpath("data")
-- macOS/Linux: ~/.local/share/nvim
-- Windows: ~/AppData/Local/nvim-data
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
--
-- 2. 将 lazypath 设置为运行时路径
-- rtp（runtime path）
-- nvim进行路径搜索的时候，除已有的路径，还会从prepend的路径中查找
-- 否则，下面 require("lazy") 是找不到的
vim.opt.rtp:prepend(lazypath)


-- hop:
local hop = {
  'smoka7/hop.nvim',
  version = "*",
  opts = {},
  config = function()
    require("hop").setup()
  end
}

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

-- surround:
-- local surround = {
--   'tpope/vim-surround',
--   version = "*",
--   opts = {},
--   config = function()
--   end
-- }

local notice = {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    }
}

local surround = {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
      require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
      })
  end
}

local neodev = {
  "folke/neodev.nvim",
  event = "VeryLazy",
}


local mason = require("plugins_config/mason")
local lsp_config = require("plugins_config/lsp_config")
local null_ls = require("plugins_config/null_ls")
local cmp = require("plugins_config/cmp")
local dap = require("plugins_config/dap")
local autopairs = require("plugins_config/autopairs")
local which_key = require("plugins_config/which_key")
local telescope = require("plugins_config/telescope")
local lualine = require("plugins_config/lualine")
local neo_tree = require("plugins_config/neo_tree")
local tree_sitter = require("plugins_config/nvim-treesitter")

local plugins = {
  telescope,
  -- 右下角通知UI
  {"j-hui/fidget.nvim", tag = "v1.0.0"},
  {'matze/vim-move'},
  -- {"shaunsingh/solarized.nvim"},
  {"ishan9299/nvim-solarized-lua"},
  {'echasnovski/mini.pairs', version = '*'},
  {'tpope/vim-dadbod', version = '*'},
  surround,
  {"wakatime/vim-wakatime", event = 'VeryLazy' },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        config = {
          week_header = {
            enable = true,
           },          
        }
      }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },
  notice,
  tree_sitter,
  lualine,
  which_key,
  neo_tree,
  mason,
  lsp_config,
  null_ls,
  cmp,
  autopairs,
  comment,
  dap,
  -- { import = "plugins" },
}

local opts = {}

require("lazy").setup(plugins, opts)

-- require("vim-colors-solarized").setup()
vim.cmd.colorscheme "solarized"


require('mini.pairs').setup()

-- require("nvim-tree").setup()
require('Comment').setup()






-- local prev_function_node = nil
-- local prev_function_name = ""

-- -- < Retrieve the name of the function the cursor is in.
-- function _G.function_surrounding_cursor()
-- 	local ts_utils = require("nvim-treesitter.ts_utils")
-- 	local current_node = ts_utils.get_node_at_cursor()

-- 	if not current_node then
-- 		return ""
-- 	end

-- 	local func = current_node

-- 	while func do
-- 		if func:type() == "function_definition" or func:type() == "function_declaration" then
-- 			break
-- 		end

-- 		func = func:parent()
-- 	end

-- 	if not func then
-- 		prev_function_node = nil
-- 		prev_function_name = ""
-- 		return ""
-- 	end

-- 	if func == prev_function_node then
-- 		return prev_function_name
-- 	end

-- 	prev_function_node = func

-- 	local find_name
-- 	find_name = function(node)
-- 		for i = 0, node:named_child_count() - 1, 1 do
-- 			local child = node:named_child(i)
-- 			local type = child:type()

-- 			if type == "identifier" or type == "operator_name" then
-- 				return (ts_utils.get_node_text(child))[1]
-- 			else
-- 				local name = find_name(child)

-- 				if name then
-- 					return name
-- 				end
-- 			end
-- 		end

-- 		return nil
-- 	end

-- 	prev_function_name = find_name(func)
-- 	return prev_function_name
-- end






-- dap set up

local cwd = vim.fn.getcwd()
local paths = '/usr/bin/python'
if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
  paths = cwd .. '/venv/bin/python'
elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
  paths =  cwd .. '/.venv/bin/python'
else
  paths = '/usr/bin/python'
end

local dap, dapui = require("dap"), require("dapui")
dap.adapters.python = function(cb, config)
	if config.request == "attach" then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	else
		cb({
			type = "executable",
			command = paths,
			args = { "-m", "debugpy.adapter" },
			options = {
				source_filetype = "python",
			},
		})
	end
end



dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			return paths
		end,
	},
	{
		type = "python",
		request = "attach",
		name = "Attach remote",
		connect = function()
			local host = vim.fn.input("Host [127.0.0.1]: ")
			host = host ~= "" and host or "127.0.0.1"
			local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
			return { host = host, port = port }
		end,
	}
}



require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})




