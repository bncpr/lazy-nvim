return {
  {
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
}
