local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }

keymap("n", "x", '"_x')
-- keymap("n", "dw", 'vb"_d')
keymap('n', '*', '*N')
keymap('n', 'n', 'nzz')
keymap('n', 'N', 'Nzz')


-- Quickly save the current buffer or all buffers
keymap('n', '<leader>w', '<CMD>update<CR>')
keymap('n', '<leader>W', '<CMD>wall<CR>')

-- leader-o/O inserts blank line below/above
keymap('n', '<leader>o', 'o<ESC>')
keymap('n', '<leader>O', 'O<ESC>')


-- Select all
keymap("n", "<C-a>", "gg<S-v>G")

keymap("n", "te", ":tabedit<Return>", opts)
keymap("n", "<tab>", ":tabnext<Return>", opts)
keymap("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap("n", "ss", ":split<Return>", opts)
keymap("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap("n", "sh", "<C-w>h")
keymap("n", "sk", "<C-w>k")
keymap("n", "sj", "<C-w>j")
keymap("n", "sl", "<C-w>l")


-- Resize window
keymap("n", "<C-w><left>", "<C-w><")
keymap("n", "<C-w><right>", "<C-w>>")
keymap("n", "<C-w><up>", "<C-w>+")
keymap("n", "<C-w><down>", "<C-w>-")

-- keymap('n', '"', '<Plug>Ysurroundiw"')
-- keymap('i', '"', '<Plug>Ysurroundiw')

-- keymap('n', '"', 'ysiw"')

-- -- Disable continuations
-- keymap("n", "<Leader>o", "o<Esc>^Da", opts)
-- keymap("n", "<Leader>O", "O<Esc>^Da", opts)

-- -- Jumplist
-- keymap("n", "<C-m>", "<C-i>", opts)

-- -- <cr> == Enter
keymap("i", "jk", "<Esc>")
keymap("v", "jk", "<Esc>")
keymap("n", "<leader>sv", "<C-w>v")
keymap("n", "<leader>sx", ":close<cr>")



keymap("n", "<leader>e", ":NvimTreeToggle<cr>")
keymap("n", "<leader>qe", ":NvimTreeFocus<cr>")

-- keymap("n", "<A-Up>", ":m-2<CR>")
-- keymap("n", "<A-Down>", ":m+2<CR>")
-- keymap("i", "<A-Up>", ":m-2<CR>")
-- keymap("i", "<A-Down>", ":m+2<CR>")
-- nvim tree 创建文件的快捷键为a
-- keymap("n", "<leader>se", ":NvimTreeFindFile<cr>")
-- keymap("i", "s", "S")



-- -- Move to window using the <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
-- -- keymap("n", "<A-Right>", "<C-w>l", opt)
-- -- keymap("n", "<A-Down>", "<C-w>j", opt)
-- -- keymap("n", "<A-Up>", "<C-w>k", opt)
-- -- keymap("n", "<A-Left>", "<C-w>h", opt)

-- -- Resize window using <ctrl> arrow keys
keymap("n", "∆", ":<Esc>:m .+1<CR>", { desc = "Increase window height" })
keymap("n", "˚", ":<Esc>:m .-2<CR>", { desc = "Increase window height" })
keymap("v", "∆", ":m '>+1<CR>gv=gv", { desc = "Increase window height" })
keymap("v", "˚", ":m '<-2<CR>gv=gv", { desc = "Increase window height" })

keymap("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- -- better up/down
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- -- Move Lines
keymap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- -- Clear search with <esc>
-- keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- -- Add undo break-points
-- keymap("i", ",", ",<c-g>u")
-- keymap("i", ".", ".<c-g>u")
-- keymap("i", ";", ";<c-g>u")

-- -- save file
-- keymap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- --keywordprg
-- keymap("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- -- better indenting
-- keymap("v", "<", "<gv")
-- keymap("v", ">", ">gv")

-- -- lazy
-- keymap("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- -- new file
keymap("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- keymap("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
-- keymap("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- keymap("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
-- keymap("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- -- formatting
-- keymap({ "n", "v" }, "<leader>cf", function()
--   Util.format({ force = true })
-- end, { desc = "Format" })

-- telescope:
local builtin = require('telescope.builtin')
keymap('n', '<leader>ff', builtin.find_files, {})
keymap('n', '<C-p>', builtin.oldfiles, {})
keymap('n', '<leader>fs', builtin.live_grep, {})
keymap("n", "<C-f>", builtin.live_grep, {})
keymap("n", "<C-l>", "<C-i>", {})
keymap('n', '<leader>fb', builtin.buffers, {})
keymap('n', '<leader>fh', builtin.help_tags, {})
keymap('n', '<leader>fc', builtin.grep_string, {})

keymap('n', '<leader>gc', builtin.git_commits	, {})
keymap('n', '<leader>gb', builtin.git_branches	, {})
keymap('n', '<leader>gs', builtin.git_status	, {})

keymap('i', '<C-o>', '<C-o>o', {})
-- -- hop
-- keymap('n', '<leader>hw', ":HopWord<cr>"	, {})
-- keymap('n', '<leader>hm', ":HopWordMW<cr>"	, {})
-- keymap('n', '<leader>hc', ":HopChar2<cr>"	, {})
-- keymap('n', '<leader>hn', ":HopChar2MW<cr>"	, {})
-- keymap('n', '<leader>hl', ":HopLine<cr>"	, {})
-- keymap('n', '<leader>hls', ":HopLineStart<cr>"	, {})


-- -- diagnostic
-- local diagnostic_goto = function(next, severity)
--   local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
--   severity = severity and vim.diagnostic.severity[severity] or nil
--   return function()
--     go({ severity = severity })
--   end
-- end
-- keymap("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
-- keymap("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
-- keymap("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
-- keymap("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
-- keymap("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
-- keymap("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
-- keymap("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- keymap("n", "<leader>uf", function() Util.format.toggle() end, { desc = "Toggle auto format (global)" })
-- keymap("n", "<leader>uF", function() Util.format.toggle(true) end, { desc = "Toggle auto format (buffer)" })
-- keymap("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
-- keymap("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
-- keymap("n", "<leader>uL", function() Util.toggle("relativenumber") end, { desc = "Toggle Relative Line Numbers" })
-- keymap("n", "<leader>ul", function() Util.toggle.number() end, { desc = "Toggle Line Numbers" })
-- keymap("n", "<leader>ud", function() Util.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
-- local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
-- keymap("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
-- if vim.lsp.inlay_hint then
--   keymap("n", "<leader>uh", function() vim.lsp.inlay_hint(0, nil) end, { desc = "Toggle Inlay Hints" })
-- end
-- keymap("n", "<leader>uT", function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end, { desc = "Toggle Treesitter Highlight" })

-- -- lazygit
-- keymap("n", "<leader>gg", function() Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
-- keymap("n", "<leader>gG", function() Util.terminal({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })

-- -- quit
-- keymap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- -- highlights under cursor
-- keymap("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- -- LazyVim Changelog
-- keymap("n", "<leader>L", function() Util.news.changelog() end, { desc = "LazyVim Changelog" })

-- -- floating terminal
-- local lazyterm = function() Util.terminal(nil, { cwd = Util.root() }) end
-- keymap("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
-- keymap("n", "<leader>fT", function() Util.terminal() end, { desc = "Terminal (cwd)" })
-- keymap("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
-- keymap("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- -- Terminal keymappings
-- keymap("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
-- keymap("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
-- keymap("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
-- keymap("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
-- keymap("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
-- keymap("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
-- keymap("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- -- windows
-- keymap("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
-- keymap("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
-- keymap("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
-- keymap("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
-- keymap("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
-- keymap("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- -- tabs
-- keymap("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- keymap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
-- keymap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- keymap("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- keymap("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- keymap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })


-- -- -- Global mappings.
-- -- -- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
-- -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- -- -- Use LspAttach autocommand to only map the following keys
-- -- -- after the language server attaches to the current buffer
-- -- vim.api.nvim_create_autocmd('LspAttach', {
-- --   group = vim.api.nvim_create_augroup('UserLspConfig', {}),
-- --   callback = function(ev)
-- --     -- Enable completion triggered by <c-x><c-o>
-- --     vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

-- --     -- Buffer local mappings.
-- --     -- See `:help vim.lsp.*` for documentation on any of the below functions
-- --     local opts = { buffer = ev.buf }
-- --     vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
-- --     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
-- --     vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
-- --     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
-- --     vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
-- --     vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
-- --     vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
-- --     vim.keymap.set('n', '<space>wl', function()
-- --       print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- --     end, opts)
-- --     vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
-- --     vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
-- --     vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
-- --     vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
-- --     vim.keymap.set('n', '<leader>fw', function()
-- --       vim.lsp.buf.format { async = true }
-- --     end, opts)
-- --   end,
-- -- })
