local fn = vim.fn
local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp
local diagnostic = vim.diagnostic

local utils = require("utils")

-- set quickfix list from diagnostics in a certain buffer, not the whole workspace
local set_qflist = function(buf_num, severity)
  local diagnostics = nil
  diagnostics = diagnostic.get(buf_num, { severity = severity })

  local qf_items = diagnostic.toqflist(diagnostics)
  vim.fn.setqflist({}, ' ', { title = 'Diagnostics', items = qf_items })

  -- open quickfix by default
  vim.cmd [[copen]]
end



-- vim.notify("导入custom")
local custom_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false

  -- Mappings.
  local map = function(mode, l, r, opts)
    opts = opts or {}
    opts.silent = true
    opts.noremap = true
    opts.buffer = bufnr
    keymap.set(mode, l, r, opts)
  end
  -- vim.keymap.set("n", "ga", print("按下了gp"), { desc = "go to definition" })
  map('n', 'gD', vim.lsp.buf.declaration)
  map("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
  map("n", "K", vim.lsp.buf.hover)
  map("n", "<C-]>", vim.lsp.buf.definition)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
  map("n", "<C-k>", vim.lsp.buf.signature_help)

  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition)

  map("n", "<space>rn", vim.lsp.buf.rename, { desc = "varialbe rename" })
  map("n", "gr", vim.lsp.buf.references, { desc = "show references" })
  map("n", "[d", diagnostic.goto_prev, { desc = "previous diagnostic" })
  map("n", "]d", diagnostic.goto_next, { desc = "next diagnostic" })
  -- this puts diagnostics from opened files to quickfix
  map("n", "<space>qw", diagnostic.setqflist, { desc = "put window diagnostics to qf" })
  -- this puts diagnostics from current buffer to quickfix
  map("n", "<space>qb", function() set_qflist(bufnr) end, { desc = "put buffer diagnostics to qf" })
  map("n", "<space>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
  map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "add workspace folder" })
  map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "remove workspace folder" })
  map("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- inspect(vim.lsp.buf.list_workspace_folders())
  end, { desc = "list workspace folder" })

  -- Set some key bindings conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    -- vim.notify("format is enable")
    map("n", "<space>fw", function() vim.lsp.buf.format { async = true } end, { desc = "format code" })
  else
    -- vim.notify("format is not enable")
  end

  api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local float_opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always", -- show source in diagnostic popup window
        prefix = " ",
      }

      vim.b.diagnostics_pos = vim.b.diagnostics_pos or { nil, nil }

      local cursor_pos = api.nvim_win_get_cursor(0)
      if (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
          and #diagnostic.get() > 0
      then
        diagnostic.open_float(nil, float_opts)
      end

      vim.b.diagnostics_pos = cursor_pos
    end,
  })

  -- The blow command will highlight the current variable and its usages in the buffer.
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd([[
      hi! link LspReferenceRead Visual
      hi! link LspReferenceText Visual
      hi! link LspReferenceWrite Visual
    ]])

    local gid = api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    api.nvim_create_autocmd("CursorHold", {
      group = gid,
      buffer = bufnr,
      callback = function()
        lsp.buf.document_highlight()
      end
    })

    api.nvim_create_autocmd("CursorMoved", {
      group = gid,
      buffer = bufnr,
      callback = function()
        lsp.buf.clear_references()
      end
    })
  end

  if vim.g.logging_level == "debug" then
    local msg = string.format("Language server %s started!", client.name)
    vim.notify(msg, vim.log.levels.DEBUG, { title = "Nvim-config" })
  end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require("lspconfig")

if lspconfig.pylsp then
  print('pylsp is exist')
  local venv_path = os.getenv('VIRTUAL_ENV')
  -- vim.notify(venv_path, vim.log.levels.DEBUG, { title = "Nvim-config" })
  local py_path = nil
  -- decide which python executable to use for mypy
  if venv_path ~= nil then
    py_path = venv_path .. "/bin/python3"
  else
    py_path = vim.g.python3_host_prog
  end
  lspconfig.pylsp.setup {
    on_attach = custom_attach,
    settings = {
      pylsp = {
        plugins = {
          -- formatter options
          black = { enabled = false },
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          -- linter options
          pylint = { enabled = false, executable = "pylint" },
          ruff = {
            -- formatter + Linter + isort
            enabled = true,
            extendSelect = { "ALL" },
            format = { "ALL" },
          },
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          -- type checker
          pylsp_mypy = {
            enabled = true,
            overrides = { "--python-executable", py_path, true },
            report_progress = true,
            live_mode = false
          },
          -- auto-completion options
          jedi_completion = { fuzzy = true },
          -- import sorting
          isort = { enabled = false },
        },
      },
    },
    flags = {
      debounce_text_changes = 200,
    },
    capabilities = capabilities,
  }
end

-- if lspconfig.ruff_lsp then
--   lspconfig.ruff_lsp.setup{
--     on_attach = custom_attach,
--     init_options = {
--       settings = {
--         -- Any extra CLI arguments for `ruff` go here.
--         args = {},
--       }
--     }
--   }
-- end


-- if utils.executable('pyright') then
--   vim.notify("pyright a found!", vim.log.levels.WARN, {title = 'Nvim-config'})
--   lspconfig.pyright.setup{
--     on_attach = custom_attach,
--     capabilities = capabilities
--   }
-- else
--   vim.notify("pyright not found!", vim.log.levels.WARN, {title = 'Nvim-config'})
-- end

-- if utils.executable("ltex-ls") then
--   lspconfig.ltex.setup {
--     on_attach = custom_attach,
--     cmd = { "ltex-ls" },
--     filetypes = { "text", "plaintex", "tex", "markdown" },
--     settings = {
--       ltex = {
--         language = "en"
--       },
--     },
--     flags = { debounce_text_changes = 300 },
--   }
-- end

-- if utils.executable("clangd") then
--   lspconfig.clangd.setup {
--     on_attach = custom_attach,
--     capabilities = capabilities,
--     filetypes = { "c", "cpp", "cc" },
--     flags = {
--       debounce_text_changes = 500,
--     },
--   }
-- end


-- set up vim-language-server
-- if utils.executable("vim-language-server") then
--   lspconfig.vimls.setup {
--     on_attach = custom_attach,
--     flags = {
--       debounce_text_changes = 500,
--     },
--     capabilities = capabilities,
--   }
-- else
--   vim.notify("vim-language-server not found! checi it please", vim.log.levels.WARN, { title = "Nvim-config" })
-- end

-- -- set up bash-language-server
-- if utils.executable("bash-language-server") then
--   lspconfig.bashls.setup {
--     on_attach = custom_attach,
--     capabilities = capabilities,
--   }
-- end

-- if utils.executable("lua-language-server") then
--   -- settings for lua-language-server can be found on https://github.com/LuaLS/lua-language-server/wiki/Settings .
--   lspconfig.lua_ls.setup {
--     on_attach = custom_attach,
--     settings = {
--       Lua = {
--         runtime = {
--           -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--           version = "LuaJIT",
--         },
--         diagnostics = {
--           -- Get the language server to recognize the `vim` global
--           globals = { "vim" },
--         },
--         workspace = {
--           -- Make the server aware of Neovim runtime files,
--           -- see also https://github.com/LuaLS/lua-language-server/wiki/Libraries#link-to-workspace .
--           -- Lua-dev.nvim also has similar settings for lua ls, https://github.com/folke/neodev.nvim/blob/main/lua/neodev/luals.lua .
--           library = {
--             fn.stdpath("data") .. "/lazy/emmylua-nvim",
--             fn.stdpath("config"),
--           },
--           maxPreload = 2000,
--           preloadFileSize = 50000,
--         },
--       },
--     },
--     capabilities = capabilities,
--   }
-- end

-- Change diagnostic signs.
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- global config for diagnostic
diagnostic.config {
  -- Use underline for diagnostics
  underline = false,
  -- Use virtual text for diagnostics
  virtual_text = false,
  -- Use signs for diagnostics
  signs = true,
  -- Sort diagnostics by severity
  severity_sort = true,
}

lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  underline = false,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
})

-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})
