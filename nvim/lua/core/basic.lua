local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = "\\"

g.surround_no_mappings = 1

-- enable为开启高亮，但尊重当前主题的配置，如果需要强行高亮可以使用"on"
opt.syntax = "enable"

opt.bg = 'light'
-- 显示行号
opt.number = true
-- tab等同2个空格
opt.tabstop = 2
-- 手动缩进为2个空格
opt.shiftwidth = 2
-- 空格代替tab
opt.expandtab = true
-- 新行对齐当前行
opt.autoindent = true
opt.smartindent = true
-- 切分窗口向右开启
opt.splitright = true
-- 切分窗口向下开启
opt.splitbelow = true
-- 剪贴板
opt.clipboard:append("unnamedplus")
-- 高亮所在行
opt.cursorline = true
-- 显示左侧图标示例
opt.signcolumn = "yes"
-- 搜索忽略大小写
opt.ignorecase = true
opt.smartcase = true
-- 边输入边搜索
opt.incsearch = true
-- 高亮搜索内容
opt.hlsearch = true
-- 当前文件将被外部程序修改时自动加载
opt.autoread = true
vim.o.hidden = true

vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.wrapscan = false

opt.title = true
opt.backup = false
opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 2
opt.scrolloff = 10
opt.shell = "zsh"
opt.backupskip = { "/tmp/*", "/private/tmp/*" }
opt.inccommand = "split"
opt.smarttab = true
opt.breakindent = true
opt.wrap = false          -- No Wrap lines
opt.backspace = { "start", "eol", "indent" }
opt.path:append({ "**" }) -- Finding files - Search down into subfolders
opt.wildignore:append({ "*/node_modules/*" })
opt.splitkeep = "cursor"
opt.mouse = 'a'

-- opt.netrw_list_hide = 0

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
opt.formatoptions:append({ "r" })

vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

if vim.fn.has("nvim-0.8") == 1 then
	opt.cmdheight = 0
end



-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


-- 设置日志级别为 DEBUG
vim.lsp.set_log_level("debug")

-- 设置日志文件路径
vim.cmd('let $NVIM_LOG_FILE = expand("~/.cache/nvim/nvim.log")')


-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
-- 在进行复制的时候高亮一下
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
