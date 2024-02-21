function Common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    -- print('获取到默认配置')
    return cmp_nvim_lsp.default_capabilities()
  else
    -- print('获取到自定义配置')
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return capabilities
end

-- set quickfix list from diagnostics in a certain buffer, not the whole workspace
local diagnostic = vim.diagnostic
local set_qflist = function(buf_num, severity)
  local diagnostics = diagnostic.get(buf_num, { severity = severity })

  local qf_items = diagnostic.toqflist(diagnostics)
  vim.fn.setqflist({}, ' ', { title = 'Diagnostics', items = qf_items })

  -- open quickfix by default
  vim.cmd [[copen]]
end


local function lsp_keymaps(client, bufnr)
  vim.notify("will format is not enable")
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- client.server_capabilities.hoverProvider = false
  -- keymap(bufnr, "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

  -- Mappings.
  local map = function(l, r, opts)
    opts = opts or {}
    -- opts.silent = true
    -- opts.noremap = true
    opts.buffer = bufnr
    vim.keymap.set('n', l, r, opts)
  end

  map("<space>qb", function() set_qflist(bufnr) end, { desc = "put buffer diagnostics to qf" })
  map('gD', vim.lsp.buf.declaration)
  map("gd", vim.lsp.buf.definition, { desc = "go to definition" })
  map("K", vim.lsp.buf.hover, { desc = 'show hover' })

  map("<C-]>", vim.lsp.buf.definition)
  map('n', 'gi', vim.lsp.buf.implementation)
  map("<C-k>", vim.lsp.buf.signature_help)
  map('n', '<space>D', vim.lsp.buf.type_definition)

  map("<space>rn", vim.lsp.buf.rename, { desc = "varialbe rename" })
  map("gr", vim.lsp.buf.references, { desc = "show references" })
  map("[d", diagnostic.goto_prev, { desc = "previous diagnostic" })
  map("]d", diagnostic.goto_next, { desc = "next diagnostic" })
  -- this puts diagnostics from opened files to quickfix
  map("<space>qw", diagnostic.setqflist, { desc = "put window diagnostics to qf" })

  map("<space>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
  map("<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "add workspace folder" })
  map("<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "remove workspace folder" })
  map("<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- inspect(vim.lsp.buf.list_workspace_folders())
  end, { desc = "list workspace folder" })

  -- Set some key bindings conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    vim.notify("format name is " .. client.server_capabilities.documentFormattingProvider.name)
    map("<space>fw", function() vim.lsp.buf.format { async = true } end, { desc = "format code" })
  else
    vim.notify("format is not enable")
  end
end



local lsp_config = {
  'neovim/nvim-lspconfig',
  -- event = { "BufReadPre", "BufNewFile" },
  -- version = "*",
  -- event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- "folke/neodev.nvim",
    -- "j-hui/fidget.nvim",
  },
  -- on_attach = function(client, bufnr)
  --   lsp_keymaps(client, bufnr)
  -- end,
  -- capabilities = Common_capabilities(),
  config = function()
    local servers = {
      lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
      },
      cssls = {},
      html = {},
      tsserver = {},
      astro = {},
      pyright = {},
      bashls = {},
      jsonls = {},
      yamlls = {},
      marksman = {},
      tailwindcss = {},
      eslint_d = {},
      prettierd = {},
      -- "ruff_lsp"
    }
    local lspconfig = require "lspconfig"
    local icons = require("plugins_config.icons")

    -- local default_diagnostic_config = {
    --   signs = {
    --     active = true,
    --     values = {
    --       { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    --       { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
    --       { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
    --       { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
    --     },
    --   },
    --   virtual_text = false,
    --   update_in_insert = false,
    --   underline = true,
    --   severity_sort = true,
    --   float = {
    --     focusable = true,
    --     style = "minimal",
    --     border = "rounded",
    --     source = "always",
    --     header = "",
    --     prefix = "",
    --   },
    -- }

    -- vim.diagnostic.config(default_diagnostic_config)

    -- for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    --   vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    -- end

    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    -- require("lspconfig.ui.windows").default_options.border = "rounded"

    -- for _, server in pairs(servers) do
    --   local opts = {
    --     on_attach = function(client, bufnr)
    --       lsp_keymaps(client, bufnr)
    --     end,
    --     capabilities = Common_capabilities(),
    --   }

    --   local require_ok, settings = pcall(require, "user.lspsettings." .. server)
    --   if require_ok then
    --     -- opts = vim.tbl_deep_extend("force", settings, opts)
    --   end

    --   if server == "lua_ls" then
    --     require("neodev").setup {}
    --   end

    --   lspconfig[server].setup(opts)
    -- end


    require("mason").setup {
      ui = {
        border = "rounded",
      },
    }
    require("mason-lspconfig").setup {
      ensure_installed = vim.tbl_keys(servers),
      handles = {
        function (server_name)
          require("lspconfig")[server_name].setup {
            on_attach = function(client, bufnr)
              lsp_keymaps(client, bufnr)
            end,
            -- settings = servers[server_name],
            -- capabilities = Common_capabilities(),
          }
        end
      }
    }
  end
}

return lsp_config
