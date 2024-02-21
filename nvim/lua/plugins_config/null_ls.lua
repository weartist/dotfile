local null_ls = 
{ "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require "null-ls"
      local formatting = null_ls.builtins.formatting
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      
      null_ls.setup {
        sources = {
          formatting.stylua,
          formatting.prettier,
          formatting.ruff,
          formatting.prettier.with {
            extra_filetypes = { "toml" },
            -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
          },
          null_ls.builtins.diagnostics.ruff,
          -- null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.completion.spell,
        },
        debug = true,
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end
      }


    end
}

return null_ls
