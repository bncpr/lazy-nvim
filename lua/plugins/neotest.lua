return {
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          runner = "pytest",
          -- python = ".venv/bin/python",
          is_test_file = function(file_path)
            return string.find(file_path, "test")
          end,
        },
      },
    },
  },
}
