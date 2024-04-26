return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>sR", false },
      { "<leader>.", "<cmd>Telescope resume<cr>", desc = "Resume" },
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")
      opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
        buffers = {
          mappings = {
            i = {
              ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
            },
            n = {
              ["dd"] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        window = {
          mappings = {
            ["s"] = "vsplit_with_window_picker",
            ["S"] = "split_with_window_picker",
          },
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          ---@diagnostic disable-next-line: unused-local
          handler = function(file_path)
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },
  },
  {
    "ckolkey/ts-node-action",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter" },
    keys = {
      {
        "<leader>cj",
        function()
          require("ts-node-action").node_action()
        end,
        desc = "Trigger Node Action",
      },
    },
  },
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  -- {
  --   "L3MON4D3/LuaSnip",
  --   keys = function()
  --     return {}
  --   end,
  -- },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.completion = vim.tbl_extend("force", opts.completion, { autocomplete = false })

      -- opts.mapping = vim.tbl_extend("force", opts.mapping, {
      --   ["<Tab>"] = cmp.mapping(function(fallback)
      --     if cmp.visible() then
      --       cmp.select_next_item()
      --       -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
      --       -- this way you will only jump inside the snippet region
      --     elseif luasnip.expand_or_locally_jumpable() then
      --       luasnip.expand_or_jump()
      --     else
      --       fallback()
      --     end
      --   end, { "i", "s" }),
      --   ["<S-Tab>"] = cmp.mapping(function(fallback)
      --     if cmp.visible() then
      --       cmp.select_prev_item()
      --     elseif luasnip.jumpable(-1) then
      --       luasnip.jump(-1)
      --     else
      --       fallback()
      --     end
      --   end, { "i", "s" }),
      -- })
    end,
  },
}
