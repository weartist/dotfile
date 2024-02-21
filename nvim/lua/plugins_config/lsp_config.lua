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
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- client.server_capabilities.hoverProvider = false
  -- keymap(bufnr, "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  -- Mappings.
  local map = function(l, r, opts)
    opts = opts or {}
    opts.silent = true
    opts.noremap = true
    opts.buffer = bufnr
    vim.keymap.set('n', l, r, opts)
  end

  map("<leader>qb", function() set_qflist(bufnr) end, { desc = "put buffer diagnostics to qf" })
  -- map('gD', vim.lsp.buf.declaration)
  map("gd", require('telescope.builtin').lsp_definitions, { desc = "[G]o to [d]efinition" })
  map('K', '<cmd>Lspsaga hover_doc<CR>', { desc = 'show hover' })

  map("<leader>da", require('telescope.builtin').diagnostics, { desc = '[D]i[a]gnostics' })
  map('gi', require('telescope.builtin').lsp_implementations, { desc = '[G]oto [i]mplementations' })
  map("<C-k>", vim.lsp.buf.signature_help)
  map('<leader>D', vim.lsp.buf.type_definition)

  map("<leader>rn", '<cmd>Lspsaga rename ++project<CR>', { desc = "[R]e[n]ame" })
  -- map("gr", vim.lsp.buf.references, { desc = "show references" })
  map("gr", require('telescope.builtin').lsp_references, { desc = "[G]oto [r]eferences" })
  map("[d", diagnostic.goto_prev, { desc = "previous diagnostic" })
  map("]d", diagnostic.goto_next, { desc = "next diagnostic" })
  -- this puts diagnostics from opened files to quickfix
  map("<leader>qw", diagnostic.setqflist, { desc = "put window diagnostics to qf" })

  map("<leader>ca", '<cmd>Lspsaga code_action<CR>', { desc = "LSP code action" })
  map("<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "add workspace folder" })
  map("<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "remove workspace folder" })
  map("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    inspect(vim.lsp.buf.list_workspace_folders())
  end, { desc = "list workspace folder" })

  -- Set some key bindings conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    vim.notify("format name is " .. client.server_capabilities.documentFormattingProvider.name)
    map("<leader>fw", function() vim.lsp.buf.format { async = true } end, { desc = "format code" })
  else
    vim.notify("format is not enable")
  end
end



local lsp_config = {
  'neovim/nvim-lspconfig',
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig",
    "folke/neodev.nvim",
    {"j-hui/fidget.nvim", tag = "v1.0.0"},
    {"nvimdev/lspsaga.nvim"}
  },
  config = function()
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        }
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
      rust_analyzer = {}
      -- eslint_d = {},
      -- prettierd = {},
      -- "ruff_lsp"
    }
    local lspconfig = require "lspconfig"
    local icons = require("plugins_config.icons")
    require("neodev").setup()
    require("fidget").setup()
    require("lspsaga").setup()
    require("mason").setup {
      ui = {
        border = "rounded",
      },
    }
    -- require("mason-lspconfig").setup({
    --   ensure_installed = vim.tbl_keys(servers),
    --   handlers = {
    --     function (server_name)
    --       require("lspconfig")[server_name].setup {
    --         -- settings = servers[server_name],
    --         on_attach = function(client, bufnr)
    --           lsp_keymaps(client, bufnr)
    --         end,
    --         capabilities = Common_capabilities(),
    --       }
    --     end,
    --   }
    -- })
    for server, config in pairs(servers) do
      require("lspconfig")[server].setup (
        vim.tbl_deep_extend('keep',
          {
            on_attach = function(client, bufnr)
              lsp_keymaps(client, bufnr)
            end,
            capabilities = Common_capabilities()
          },
        config)
        )
    end
  end
}

return lsp_config
