-- -- 记录的命令历史
-- -- vim.cmd('set history=100')
-- -- vim.cmd('set historysearch=100')


-- -- utf-8
-- vim.g.encoding = "UTF-8"
-- vim.o.fileencoding = "UTF-8"

-- -- jkhl 移动光标周围保留8行
-- vim.o.scrolloff = 8
-- vim.o.sidescrolloff = 8

-- -- 使用相对行号
-- -- vim.wo.number = true
-- -- vim.wo.relativenumber = true

-- -- 高亮所在行
-- -- vim.wo.cursorline = true


-- -- 显示左侧图标事例
-- -- vim.wo.signcolumn = "yes"

-- -- 缩进2 个空格等于一个tab
-- -- vim.o.tabstop = 2
-- -- vim.bo.tabstop = 2
-- -- vim.o.softtabstop = -1
-- -- vim.o.shiftround = 4

-- -- vim.o.shiftwidth = 2
-- -- vim.bo.shiftwidth = 2
-- -- -- 空格替代tab
-- -- vim.o.expandtab = true
-- -- vim.bo.expandtab = true

-- -- 新行对其当前行
-- -- vim.o.autoindent = true
-- vim.bo.autoindent = true
-- vim.o.smartindent = true
-- -- 搜索大小写忽略 除非包含大写
-- vim.o.ingorecash = true
-- vim.o.smartcase = true
-- -- 搜索不要高亮
-- -- vim.o.hlsearch = true
-- -- 边输入边搜索
-- vim.o.insearch = true
-- -- 命令行高未2 提供足够的显示空间
-- vim.o.cmdheight = 1

-- -- 当前文件将被外部程序修改时自动加载
-- vim.o.autoread = true
-- vim.bo.autoread = true
-- -- 禁止折行
-- vim.wo.wrap = false
-- -- 光标在行首尾<Left><Right> 可以跳转到下一行
-- vim.o.whichwrap = "<,>,[,]"
-- -- 允许隐藏被修改的buffer
-- vim.o.hidden = true
-- -- 鼠标支持
-- vim.o.mouse = "a"
-- -- 禁止创建备份文件
-- vim.o.backup = false
-- vim.o.writebackup = false
-- vim.o.swapfile = false


-- -- smaller updatetiem
-- vim.o.updatetime = 300
-- -- 设置timeoutlen 为等待键盘快捷键连击时间为500 ms，
-- vim.o.timeoutlen = 500
-- -- split window 从下边 右边出现
-- vim.o.splitbelow = true
-- vim.o.splitright = true
-- -- 自动不全不自动选中
-- vim.g.completeopt = "menu,menuone,noselect,noinsert"
-- -- 样式
-- vim.o.background = "dark"
-- vim.o.termguicolors = true
-- vim.opt.termguicolors = true
-- -- 不可见字符的显示，这里只把空格显示为一个点
-- vim.o.list = true
-- vim.o.listcharts = "space:·"
-- -- 补全增强
-- vim.o.wildmenu = true
-- -- Dont' pass messages to |ins-completin menu|
-- vim.o.shortmess = vim.o.shortmess .. "c"
-- -- 补全最多显示10行
-- vim.o.pumheight = 10
-- -- 永远显示 tabline
-- vim.o.showtabline = 2
-- -- 使用增强状态栏插件后不再需要 vim 的模式提示
-- vim.o.showmode = true
-- -- 配置剪贴板
-- vim.opt.clipboard = 'unnamedplus'

-- -- 搜索不要高亮
-- -- vim.o.hlsearch = false
-- -- 边输入边搜索
-- vim.o.insearch = true
