-- return {
--   "nvim-telescope/telescope.nvim",
--   dependencies = { "nvim-lua/plenary.nvim"},
--   branch = '0.1.x',
--   -- config = function()
--   --   require("telescope").setup()
--   -- end
-- }


return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
    -- branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  -- config = function()
  --   local actions = require('telescope.actions')
  --   require('telescope').setup{
  --     defaults = {
  --       mappings = {
  --         i = {
  --           ["C-j"] = actions.move_selection_next,
  --           ["C-k"] = actions.move_selection_previous,
  --         },
  --       },
  --     },
  --   }
  -- end
  }
